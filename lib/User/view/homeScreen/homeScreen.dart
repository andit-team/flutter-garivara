import 'dart:async';
import 'dart:typed_data';
import 'package:andgarivara_driver/Utils/appConst.dart';
import 'package:andgarivara_driver/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara_driver/Utils/controller/userLocation.dart';
import 'package:andgarivara_driver/Utils/widgets/jumpingDots.dart';
import 'package:andgarivara_driver/Utils/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  Set<Marker> _markers = Set<Marker>();
  Set<Circle> _circles = Set<Circle>();


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
        //TODO crossFades
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
              markers: _markers,
              circles: _circles,
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


  functions() async{
    Uint8List driverImageData = await getDriverMarker();
    Uint8List destinationImageData = await getDestinationMarker();
    LatLng staticLatLng = LatLng(22.8144074,89.5663444);
    destinationMarkerAndCircle(destinationImageData,'customer','customerRadius',staticLatLng);

    Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best,intervalDuration: Duration(milliseconds: 2000)).listen((Position position) {
      LatLng latLng = LatLng(position.latitude, position.longitude);
      userLocation.updateLocation(latLng);
      updateMarkerAndCircle(position,driverImageData,'driver','driverRadius',latLng);
    });

    _setPolyLines(userLocation.location.value,staticLatLng);

    setState(() {
      loading = false;
    });
  }

  Future<Uint8List> getDriverMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  Future<Uint8List> getDestinationMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/images/passenger_icon.png");
    return byteData.buffer.asUint8List();
  }

  void destinationMarkerAndCircle(imageData,vehicleMarker,vehicleRadius,staticLatLng) {

    this.setState(() {
      _markers.add(
          Marker(
              markerId: MarkerId(vehicleMarker),
              position: staticLatLng,
              draggable: false,
              zIndex: 2,
              flat: true,
              anchor: Offset(0.5, 0.5),
              icon: BitmapDescriptor.fromBytes(imageData),
          )
      );
      _circles.add(Circle(
          circleId: CircleId(vehicleRadius),
          center: staticLatLng,
          radius: 3000,
          zIndex: 1,
          strokeColor: Colors.blue.withOpacity(0.2),
          fillColor: Colors.blue.withAlpha(70).withOpacity(0.2),
      )
      );
    });
  }

  void updateMarkerAndCircle(position,imageData,vehicleMarker,vehicleRadius,latLng) {

    this.setState(() {
      _markers.add(
          Marker(
              markerId: MarkerId(vehicleMarker),
              position: latLng,
              rotation: position.heading,
              draggable: false,
              zIndex: 2,
              flat: true,
              anchor: Offset(0.5, 0.5),
              icon: BitmapDescriptor.fromBytes(imageData))
      );
      _circles.add(
          Circle(
              circleId: CircleId(vehicleRadius),
              center: latLng,
              zIndex: 1,
              strokeColor: Colors.blue.withOpacity(0.2),
              fillColor: Colors.blue.withAlpha(70).withOpacity(0.2))
      );
    });
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController.complete(controller);
    });
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
  _setPolyLines(LatLng source, LatLng destination)  {
    polylineCoordinates.clear();
    polylinePoints.getRouteBetweenCoordinates(DotEnv().env['google_api_key'],
        PointLatLng(source.latitude, source.longitude),
        PointLatLng(destination.latitude, destination.longitude)).then((valuePoints) {
      if (valuePoints.points.isNotEmpty) {
        valuePoints.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));});
        setState(() {
          _polyLines.add(Polyline(
              width: 2,
              startCap: Cap.roundCap,
              endCap: Cap.roundCap,
              polylineId: PolylineId("poly"),
              color: AppConst.appBlue,
              points: polylineCoordinates));
        });
      }
    });
  }

}
