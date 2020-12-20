import 'dart:async';
import 'dart:typed_data';
import 'package:andgarivara_driver/Utils/appConst.dart';
import 'package:andgarivara_driver/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara_driver/Utils/controller/userLocation.dart';
import 'package:andgarivara_driver/Utils/widgets/jumpingDots.dart';
import 'package:andgarivara_driver/Utils/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
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
  bool loading = true;

  CameraPosition initialCameraPosition;
  Completer<GoogleMapController> mapController = Completer();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Polyline> _polyLines = Set<Polyline>();

  Marker marker;
  Circle circle;

  final GetSizeConfig sizeConfig = Get.find();
  GetUserLocation userLocation = Get.find();

  @override
  void initState() {
    functions();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
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
              initialCameraPosition: CameraPosition(
                  target: userLocation.location.value,
                  zoom: 18,
                  tilt: 15
              ),
              onMapCreated: _onMapCreated,
              //onTap: setNewLocation,
              polylines: _polyLines,
              markers: Set.of((marker != null) ? [marker] : []),
              circles: Set.of((circle != null) ? [circle] : []),
            )
        ),
        Positioned(
          right: sizeConfig.width*30,
          bottom: sizeConfig.height*30,
          child: FloatingActionButton(

            onPressed: ()async {
              await _updateCameraPosition(userLocation.location.value);
            },
            child: Icon(Icons.location_on),
          ),
        ),
      ],
    );
  }


  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }


  functions() async{


    Uint8List imageData = await getMarker();

    //await setInitialPosition(userPosition);

    Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best,intervalDuration: Duration(milliseconds: 2000)).listen((Position position) {
      userLocation.updateLocation(LatLng(position.latitude, position.longitude));
      updateMarkerAndCircle(position,imageData);
    });

    setState(() {
      loading = false;
    });
  }

  void updateMarkerAndCircle(position,imageData) {
    LatLng latLng = LatLng(position.latitude, position.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latLng,
          rotation: position.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          center: latLng,
          radius: position.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue.withOpacity(0.2),
          fillColor: Colors.blue.withAlpha(70).withOpacity(0.2));
    });
  }

/*  setInitialPosition(LatLng initialPosition) async{
    initialCameraPosition = CameraPosition(
        target: initialPosition,
        zoom: 18,
        tilt: 15
    );
    await addMarker(initialPosition,'currentMarker');
  }*/


  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController.complete(controller);
    });
  }

/*  setNewLocation(LatLng location) {
    setState(() {
      addMarker(location);
    });
  }*/

/*  addMarker(LatLng location, [String s]) async{
    position = location;
    gMarker.add(Marker(
        markerId: MarkerId(s ?? 'userLocation'),
        position: location
    ));

    await _updateCameraPosition(location);
  }*/


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
