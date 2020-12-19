import 'dart:async';

import 'package:andgarivara_driver/Utils/appConst.dart';
import 'package:andgarivara_driver/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara_driver/Utils/controller/userLocation.dart';
import 'package:andgarivara_driver/Utils/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  CameraPosition initialCameraPosition;
  Set<Marker> gMarker = Set<Marker>();
  LatLng position;
  LatLng userPosition;
  Completer<GoogleMapController> mapController = Completer();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Polyline> _polyLines = Set<Polyline>();
  Set<Circle> circles = Set<Circle>();

  bool loading = true;
  final GetSizeConfig sizeConfig = Get.find();

  @override
  void initState() {
    functions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: AnimatedCrossFade(
        duration: AppConst.duration,
        firstChild: Loader(),
        secondChild: googleMap(),
        crossFadeState: loading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    );
  }


  Widget googleMap(){
    return Stack(
      children: [
        Container(
            width: sizeConfig.width*1000,
            height: sizeConfig.height*1000,
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
              onTap: setNewLocation,
              polylines: _polyLines,
              // circles: circles,
            )
        ),
        Positioned(
          right: sizeConfig.width*30,
          bottom: sizeConfig.height*30,
          child: FloatingActionButton(

            onPressed: ()async {
              await _updateCameraPosition(userPosition);
            },
            child: Icon(Icons.location_on),
          ),
        ),
      ],
    );
  }



  functions() async{
    GetUserLocation userLocation = Get.find();
    userPosition = userLocation.location.value;

    await setInitialPosition(userPosition);
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
    await addMarker(initialPosition,'currentMarker');
   // await addCircle(initialPosition);
  }

/*  addCircle(latLog){
    circles = Set.from([Circle(
      circleId: CircleId('circle'),
      center: LatLng(latLog.latitude, latLog.longitude),
      radius: 0,
    )]);
  }*/



  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController.complete(controller);
    });
  }

  setNewLocation(LatLng location) {
    setState(() {
      addMarker(location);
    });
  }

  addMarker(LatLng location, [String s]) async{
    position = location;
    gMarker.add(Marker(
        markerId: MarkerId(s ?? 'userLocation'),
        position: location
    ));

    await _updateCameraPosition(location);
  }


  _updateCameraPosition(loc) async {
    CameraPosition cPosition = CameraPosition(
      zoom: 18,
      tilt: 15,
      target: LatLng(loc.latitude, loc.longitude),
    );
    GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }
}
