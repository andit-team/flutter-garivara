import 'dart:async';

import 'package:andgarivara/Utils/controller/userLocation.dart';
import 'package:andgarivara/Utils/widgets/loader.dart';
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
  bool loading = true;

  Set<Marker> gMarker = Set<Marker>();
  Position position;
  CameraPosition initialCameraPosition;
  Completer<GoogleMapController> mapController = Completer();


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
      body: loading ? Loader() : GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: gMarker,

      ),
    );
  }












  addMarker(location) async{
    gMarker.add(Marker(
        markerId: MarkerId('marker'),
        position: location
    ));
    await getAddressFromLatLng(location);
    // await _updateCameraPosition(location);
  }

  getAddressFromLatLng(LatLng latLng) async {
    List<Address> addressList = [];
    addressList = await Geocoder.local.findAddressesFromCoordinates(Coordinates(latLng.latitude, latLng.longitude));
    // pickUpLocation.text = addressList[0].addressLine;
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

}
