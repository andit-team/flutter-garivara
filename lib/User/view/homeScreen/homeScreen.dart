import 'dart:async';
import 'dart:typed_data';
import 'package:andgarivara_driver/User/view_model/drivingDetailsData.dart';
import 'package:andgarivara_driver/Utils/appConst.dart';
import 'package:andgarivara_driver/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara_driver/Utils/controller/userLocation.dart';
import 'package:andgarivara_driver/Utils/widgets/jumpingDots.dart';
import 'package:andgarivara_driver/Utils/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
      body: Stack(
        children: [
          AnimatedCrossFade(
            duration: AppConst.duration,
            firstChild: Center(child: Loader(),),
            secondChild: googleMap(),
            crossFadeState: loading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
          DrivingDetailsData.distance.value != 0.0?AnimatedPositioned(
            bottom: 0,
            duration: AppConst.duration,
            child: AnimatedContainer(
              duration: AppConst.duration,
              constraints: BoxConstraints(
                maxWidth: Get.width,
                minWidth: Get.width,
                maxHeight: Get.height * .25,
                minHeight: Get.height * .25,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(sizeConfig.width * 100),
                      topLeft: Radius.circular(sizeConfig.width * 100)
                  ),
                  boxShadow: [
                    AppConst.shadow
                  ]
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 15,horizontal: sizeConfig.getPixels(20)),
                child: statusProcessing(),
              ),
            ),
          ):Container(),
          Positioned(
            right: sizeConfig.width*30,
            top: sizeConfig.height*30,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () async {
                await _updateCameraPosition(userLocation.location.value);
              },
              child: Icon(Icons.location_on),
            ),
          ),
          Positioned(
            right: sizeConfig.width*30,
            top: sizeConfig.height*150,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                resetEverything();
              },
              child: Icon(Icons.refresh_outlined),
            ),
          ),
        ],
      ),
    );
  }


  Widget googleMap(){
    return Container(
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
          onTap: addMarker,
          polylines: _polyLines,
          markers: _markers,
          circles: _circles,
        )
    );
  }




  addMarker(LatLng location) async{
    Uint8List destinationImageData = await getDestinationMarker();
    destinationMarkerAndCircle(destinationImageData,'customerX','customerRadiusX',location);
    await _updateCameraPosition(location);
    _setPolyLines(userLocation.location.value,location);

  }

  functions() async{
    Uint8List driverImageData = await getDriverMarker();
    Uint8List destinationImageData = await getDestinationMarker();

    List<LatLng> staticLatLngArray = [LatLng(22.814813045289004, 89.56585662823029),LatLng(22.814413184430226, 89.56638611878599),LatLng(22.813387065526847, 89.5662521512965)];

    for(int x = 0;x<staticLatLngArray.length;x++){
      destinationMarkerAndCircle(destinationImageData,'customer$x','customerRadius$x',staticLatLngArray[x]);
    }

    Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best,intervalDuration: Duration(milliseconds: 2000)).listen((Position position) {
      LatLng latLng = LatLng(position.latitude, position.longitude);
      userLocation.updateLocation(latLng);
      updateMarkerAndCircle(position,driverImageData,'driver','driverRadius',latLng);
    });

    //LatLng staticLatLng = LatLng(22.814413184430226, 89.56638611878599);
    //await _setPolyLines(userLocation.location.value,staticLatLng);
    loading = false;

  }

  Future<Uint8List> getDriverMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  Future<Uint8List> getDestinationMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/images/passenger_icon.png");
    return byteData.buffer.asUint8List();
  }

  void destinationMarkerAndCircle(imageData,customerMarker,customerRadius,staticLatLng) {
    _markers.add(
        Marker(
          markerId: MarkerId(customerMarker),
          position: staticLatLng,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData),
          onTap: ()  {
            _setPolyLines(userLocation.location.value,staticLatLng);
          },
        )
    );
    _circles.add(
        Circle(
          circleId: CircleId(customerRadius),
          center: staticLatLng,
          radius: 30,
          zIndex: 1,
          strokeColor: Colors.white.withOpacity(0.01),
          fillColor: Colors.white.withAlpha(70).withOpacity(0.01),
        )
    );
    print(_markers);
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

        DrivingDetailsData.distance.value = Geolocator.distanceBetween(source.latitude, source.longitude, destination.latitude, destination.longitude);
        print(DrivingDetailsData.distance.value);
      }
    });
  }










/*  Widget bottomSheet(){
    if(DrivingDetailsData.distance.value != 0.0){
      return statusProcessing();
    }else{
      return Container();
    }
  }*/

/*  ///   STATUS NONE
  Widget statusNone() => Padding(
    padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SpinKitPulse(
          color: Colors.grey,
        ),
      ],
    ),
  );*/

  Widget statusProcessing() => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(
        '${(DrivingDetailsData.distance.value).toStringAsFixed(2)} Meters',
        style: TextStyle(
          color: Colors.black,
          fontSize: sizeConfig.getPixels(15),
        ),
      )
    ],
  );

  resetEverything(){
    polylineCoordinates.clear();
    DrivingDetailsData.distance.value = 0.0;
    _markers.remove('customerX');
    _circles.remove('customerRadiusX');
    _updateCameraPosition(userLocation.location.value);
    print(_markers);
  }
}
