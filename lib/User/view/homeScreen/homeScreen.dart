import 'dart:async';

import 'package:andgarivara/User/view/homeScreen/chooseLocation.dart';
import 'package:andgarivara/User/view/homeScreen/widgets/homeTopTextField.dart';
import 'package:andgarivara/User/view/homeScreen/widgets/vehicleTypes.dart';
import 'package:andgarivara/Utils/controller/userLocation.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/loader.dart';
import 'package:andgarivara/Utils/widgets/redButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Utils/appConst.dart';
import '../../../Utils/controller/SizeConfigController.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  CameraPosition initialCameraPosition;
  Set<Marker> gMarker = Set<Marker>();
  LatLng position;
  LatLng initialPosition;
  Completer<GoogleMapController> mapController = Completer();


  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController dropOffLocation = TextEditingController();

  bool loading = true;

  final GetSizeConfig sizeConfig = Get.find();

  @override
  void initState() {
    super.initState();
    functions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: Stack(
          children: [
            AnimatedCrossFade(
              duration: AppConst.duration,
              firstChild: Loader(),
              secondChild: googleMap(),
              crossFadeState: loading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            ),
            chooseLocation(),
            bottomSheet(),
          ],
        ),
      ),
    );
  }

  Widget googleMap(){
    return Container(
      width: double.infinity,
      height: Get.height * .75,
      child: GoogleMap(
        compassEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        minMaxZoomPreference: MinMaxZoomPreference.unbounded,
        buildingsEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: _onMapCreated,
        markers: gMarker,
      ),
    );
  }

  Widget chooseLocation(){
    return Positioned(
      top: AppBar().preferredSize.height + Get.mediaQuery.padding.top,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HomeTextField(
              onTap: () async{
                print('123');
                pickUpLocation.text = await Get.to(ChooseLocationScreen(),arguments: 'p');
              },
              controller: pickUpLocation,
              prefix: Icons.my_location,
              label: 'Pick up Location',
            ),
            HomeTextField(
              onTap: () async{
                print('456');
                dropOffLocation.text = await Get.to(ChooseLocationScreen(),arguments: 'd');
              },
              controller: dropOffLocation,
              prefix: Icons.add_location_alt_sharp,
              label: 'Drop-off Location',
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet(){
    return Positioned(
      bottom: 0,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Get.width,
          maxHeight: Get.height * .3
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(sizeConfig.width * 100),
            topLeft: Radius.circular(sizeConfig.width * 100)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 10,
              offset: Offset(0,-3)
            )
          ]
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              selectVehicleType(),
              Icon(
                Icons.info_outline,
                size: sizeConfig.getPixels(25),
              ),
              Text(
                StringResources.homeScreenHint,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sizeConfig.getPixels(14),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 55),
                child: RedButton(
                  title: StringResources.btnHomeSearchVehicle,
                  function: (){}
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  int selectedVehicle = 0;

  Widget selectVehicleType(){
    return Container(
      height: sizeConfig.height * 100,
      padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 35),
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 10),
        shrinkWrap: true,
        itemBuilder: (_,index){
          return carType(index);
        },
      ),
    );
  }

  Widget carType(int index){
    bool selected = selectedVehicle == index;
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedVehicle = index;
        });
      },
      child: VehicleTypesCard(selected: selected,),
    );
  }

























  functions() async{
    GetUserLocation userLocation = Get.find();
    initialPosition = userLocation.location.value;
    await setInitialPosition(initialPosition);
    setState(() {
      loading = false;
    });
  }

  setInitialPosition(LatLng initialPosition) async{
    initialCameraPosition = CameraPosition(
        target: initialPosition,
        zoom: 18,
        tilt: 15
    );
    await addMarker(initialPosition);
    await getAddressFromLatLng(initialPosition);
  }

  addMarker(location) async{
    position = location;
    gMarker.add(Marker(
        markerId: MarkerId('pickup'),
        position: location
    ));
    await getAddressFromLatLng(location);
    await _updateCameraPosition(location);
  }

  getAddressFromLatLng(LatLng latLng) async {
    List<Address> addressList = [];
    addressList = await Geocoder.local.findAddressesFromCoordinates(Coordinates(latLng.latitude, latLng.longitude));
    pickUpLocation.text = addressList[0].addressLine;
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
}
