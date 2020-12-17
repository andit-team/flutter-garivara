import 'dart:async';

import 'package:andgarivara/User/view/drawerScreens/widgets/favouritePlacesWidgets/drawerTileWidget.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/controller/userLocation.dart';
import 'package:andgarivara/Utils/widgets/loader.dart';
import 'package:andgarivara/Utils/widgets/redButton.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyFavouritePlacesScreen extends StatefulWidget {
  @override
  _MyFavouritePlacesScreenState createState() => _MyFavouritePlacesScreenState();
}

class _MyFavouritePlacesScreenState extends State<MyFavouritePlacesScreen> {
  final GetSizeConfig sizeConfig = Get.find();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController editingController = TextEditingController();
  final TextEditingController editingController2 = TextEditingController();


  Set<Marker> gMarker = Set<Marker>();
  Position position;
  CameraPosition initialCameraPosition;
  Completer<GoogleMapController> mapController = Completer();
  List<Address> addressList = [];

  bool loading = true;

  GetUserLocation userLocation = Get.find();

  setData() async{
    initialCameraPosition = CameraPosition(
        target: LatLng(userLocation.location.value.latitude, userLocation.location.value.longitude),
        zoom: 18,
        tilt: 15
    );
    await addMarker(LatLng(userLocation.location.value.latitude, userLocation.location.value.longitude));
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: AppConst.appRed,
            ),
            onPressed: (){
              _scaffoldKey.currentState.openEndDrawer();
            }
          )
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/andGariVaraWithCar.png'
                  ),
                  Text(
                    'Current location :',
                    style: TextStyle(
                      color: AppConst.textLight
                    ),
                  ),
                  Text(
                    'Choto mirjapur, 12 road, 11 st. Khulna',
                    style: TextStyle(
                      fontSize: sizeConfig.getPixels(18),
                      color: AppConst.textBlue
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (_,index){
                  return DrawerTileWidget();
                },
              ),
            ),
          ],
        ),
      ),
      body: loading ? Loader() : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: gMarker,
            onMapCreated: _onMapCreated,
            onTap: setNewLocation,
            zoomControlsEnabled: true,
          ),
          selectAddress(),
          Positioned(
            bottom: sizeConfig.height * 40,
            left: sizeConfig.width * 60,
            right: sizeConfig.width * 60,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(40)),
              child: RedButton(
                  title: 'Add to Favourites',
                  function: (){
                    if(editingController.text.isEmpty){
                      Get.snackbar('Error', 'Address can not be empty');
                    }else if(editingController2.text.isEmpty){
                      Get.snackbar('Error', 'Address type can not be empty');
                    }else{
                      //TODO do things here
                    }
                  }
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget selectAddress(){
    return Positioned(
      top: AppBar().preferredSize.height + Get.mediaQuery.padding.top,
      left: sizeConfig.getPixels(30),
      right: sizeConfig.getPixels(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 30)),
            child: TextField(
              controller: editingController,
              onSubmitted: getAddressFromAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: sizeConfig.width * 20,right: sizeConfig.width * 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(sizeConfig.width * 30)
                ),
              ),
            ),
          ),
          SizedBox(height: sizeConfig.height * 10,),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 30)),
            child: TextField(
              controller: editingController2,
              decoration: InputDecoration(
                hintText: 'Address Type',
                contentPadding: EdgeInsets.only(left: sizeConfig.width * 20,right: sizeConfig.width * 130),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(sizeConfig.width * 30)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }




  addMarker(LatLng location) async{
    setState(() {
      gMarker.add(Marker(
          markerId: MarkerId('marker'),
          position: location
      ));
    });
    await getAddressFromLatLng(location);
  }

  getAddressFromLatLng(LatLng latLng) async {
    addressList = await Geocoder.local.findAddressesFromCoordinates(Coordinates(latLng.latitude, latLng.longitude));
    address = addressList[0];
    editingController.text = addressList[0].addressLine;
  }

  _updateCameraPosition(LatLng loc) async {
    CameraPosition cPosition = CameraPosition(
      zoom: 18,
      tilt: 15,
      target: LatLng(loc.latitude, loc.longitude),
    );
    GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController.complete(controller);
    });
  }

  setNewLocation(LatLng location) async{
    setState(() {
      addMarker(location);
    });
    await _updateCameraPosition(location);
  }

  Address address;

  void getAddressFromAddress(String value) async{
    addressList = await Geocoder.local.findAddressesFromQuery(value);
    editingController.text = addressList[0].addressLine;
    address = addressList[0];
    addMarker(LatLng(addressList[0].coordinates.latitude, addressList[0].coordinates.longitude));
    await _updateCameraPosition(LatLng(addressList[0].coordinates.latitude, addressList[0].coordinates.longitude));
  }
}
