import 'dart:async';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/controller/userLocation.dart';
import 'package:andgarivara/Utils/widgets/loader.dart';
import 'package:andgarivara/Utils/widgets/redButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseLocationFromMap extends StatefulWidget {
  @override
  _ChooseLocationFromMapState createState() => _ChooseLocationFromMapState();
}

class _ChooseLocationFromMapState extends State<ChooseLocationFromMap> {
  GetUserLocation userLocation = Get.find();
  final GetSizeConfig sizeConfig = Get.find();
  bool loading = true;

  Set<Marker> gMarker = Set<Marker>();
  Position position;
  CameraPosition initialCameraPosition;
  Completer<GoogleMapController> mapController = Completer();
  List<Address> addressList = [];

  TextEditingController editingController = TextEditingController();

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
    if(mounted){
      setData();
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1111)),
          child: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppConst.themeRed,
            ),
          ),
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
                title: 'Select Location',
                function: (){
                  Get.back(result: address);
                  Get.back(result: address);
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
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 30)),
        child: Stack(
          children: [
            TextField(
              controller: editingController,
              onSubmitted: getAddressFromAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: sizeConfig.width * 20,right: sizeConfig.width * 130),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(sizeConfig.width * 30)
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: InkWell(
                onTap: (){
                  Get.back(result: address);
                },
                child: Card(
                  color: AppConst.themeRed,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 30)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 20),
                    child: Icon(
                      Icons.navigate_next_outlined,
                      color: Colors.white,
                      size: sizeConfig.getPixels(30),
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
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
