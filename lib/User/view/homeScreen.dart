import 'dart:async';

import 'package:andgarivara/Utils/controller/userLocation.dart';
import 'package:andgarivara/Utils/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Utils/appConst.dart';

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

  @override
  void initState() {
    super.initState();
    functions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){
              // getInitialPosition();
            },
            icon: Icon(Icons.api),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
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
    );
  }

  Widget googleMap(){
    return Container(
      width: double.infinity,
      height: Get.height * .8,
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
    return Container();
  }
  Widget bottomSheet(){
    return Positioned(
      bottom: 0,
      child: Container(
        height: Get.height * .2,
        decoration: BoxDecoration(
          color: Colors.red
        ),
      ),
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
