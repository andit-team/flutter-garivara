// import 'dart:async';
// import 'dart:convert';
// import 'dart:math' show cos, sqrt, asin;
// import 'dart:ui';
//
// import 'package:beerapp/Customer/Database.dart';
// import 'package:beerapp/Customer/Login/CustomerReviewDriverAndTip.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
//
// import 'package:android_intent/android_intent.dart';
// import 'package:beerapp/Customer/Config.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_webservice/places.dart';
//
//
// import 'Config.dart';
//
//
// const double CAMERA_ZOOM = 18;
// const double CAMERA_TILT = 60;
// const double CAMERA_BEARING = 10;
//
// const LatLng driverLocation = LatLng(22.8111, 89.5663);
//
//
// class CustomerMapPage extends StatefulWidget {
//
//   @override
//   _CustomerMapPageState createState() => _CustomerMapPageState();
// }
// class _CustomerMapPageState extends State<CustomerMapPage> {
//   Geolocator geoLocator = Geolocator()..forceAndroidLocationManager = true;
//   GeolocationStatus geolocationStatus;
//
//   var locationOptions = LocationOptions(accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 10);
//
//
//   CameraPosition initialCameraPosition;
//   Completer<GoogleMapController> _controller = Completer();
//   StreamController streamControllerFindingID = StreamController();
//   StreamSubscription subscriptionFindingID;
//   Stream streamFindingID;
//
//   StreamController streamControllerTracking = StreamController();
//   StreamSubscription subscriptionTracking;
//   Stream streamTracking;
//
//   Set<Marker> _markers = Set<Marker>();
//   Set<Circle> _circles = Set<Circle>();
//   Set<Polyline> _polyLines = Set<Polyline>();
//
//   List<LatLng> polylineCoordinates = [];
//   List<LatLng> polylineCoordinatesForClosestCurrentStore = [];
//   List<LatLng> polylineCoordinatesForClosestStore = [];
//   LatLng initialLocation;
//
//   PolylinePoints polylinePoints = PolylinePoints();
//   String googleAPIKey = 'AIzaSyAuo-_NYLqOIQdCkQoInC-Z8bvE0NVMuC8';
//   GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: 'AIzaSyAuo-_NYLqOIQdCkQoInC-Z8bvE0NVMuC8');
//
//   BitmapDescriptor sourceIcon;
//   BitmapDescriptor destinationIcon;
//   BitmapDescriptor storeIcon;
//
//   Position currentPosition;
//   Position destinationPosition;
//
//   String _currentAddress;
//   String _destinationAddress;
//
//   double pinPillPosition = -100;
//   double totalDistance = 0.0;
//   double timeSec = 0.0;
//   double remainingTimeSec = 0.0;
//   int timeMin = 0;
//   double speed = 30000;
//   double linearBar = 1;
//
//   PinInformation currentlySelectedPin = PinInformation(
//       pinPath: '',
//       avatarPath: '',
//       location: LatLng(0, 0),
//       locationName: '',
//       labelColor: Colors.grey);
//   PinInformation sourcePinInfo;
//   PinInformation destinationPinInfo;
//
//   List<Marker> arrayMarker = [];
//   List<String> arrayMarkerAddress = [
//     '1,Ahsan Ahmed Road,Khulna,9100,Bangladesh',
//     '13,Upper Jessore Road,Khulna,,Bangladesh'
//   ];
//
//   String qrData = 'Confirmed';
//   bool delayInfo = true;
//   bool delayVehicle;
//
//   bool checkingID = true;
//   int customerID = 46;
//   bool calculateTime = true;
//
//   @override
//   void setState(fn) {
//     if(mounted) {
//       super.setState(fn);
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     streamControllerFindingID.close();
//     subscriptionFindingID.cancel();
//
//     streamControllerTracking.close();
//     subscriptionTracking.cancel();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     if (!mounted) {
//       return;
//     } else {
//       streamFindingID = streamControllerFindingID.stream;
//       streamTracking = streamControllerTracking.stream;
//
//       _checkGps();
//     }
//   }
//   //--------------------------------------------widgets and info
//   _onBarCodeBox(context) {
//     Alert(
//       context: context,
//       title:
//       "Please show this QR to our driver to confirm your product delivery.",
//       content: Center(
//         child: Container(
//           decoration: BoxDecoration(
//               color: Color(0xffF4F2FF),
//               borderRadius:
//               BorderRadius.circular(SizeConfig.safeBlockHorizontal * 1)),
//           height: SizeConfig.safeBlockVertical * 43,
//           width: SizeConfig.safeBlockHorizontal * 60,
//           child: Container(
//             decoration: BoxDecoration(
//                 color: Color(0xffF4F2FF),
//                 borderRadius:
//                 BorderRadius.circular(SizeConfig.safeBlockHorizontal * 1)),
//             child: GestureDetector(
//               onTap: () {
//                 _onSuccess(context);
//               },
//               child: Container(
//                 child: QrImage(
//                     data: orderDetails.QRCode,
//                     version: QrVersions.auto,
//                     size: SizeConfig.safeBlockHorizontal * 40),
//               ),
//             ),
//           ),
//         ),
//       ),
//       buttons: [
//         DialogButton(
//           color: Color(0xffffc600),
//           child: Text(
//             "Cancel",
//             style: TextStyle(
//                 color: Colors.white,
//                 fontSize: SizeConfig.safeBlockHorizontal * 4.0),
//           ),
//           onPressed: () => Navigator.pop(context),
//         )
//       ],
//     ).show();
//   }
//
//   _onSuccess(context) {
//     Alert(
//       context: context,
//       type: AlertType.success,
//       title: "Order Success!",
//       desc: "Give a review on our rider?",
//       buttons: [
//         DialogButton(
//             color: Color(0xffffc600),
//             child: Text(
//               "Yes",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: SizeConfig.safeBlockHorizontal * 4.0),
//             ),
//             onPressed: (){
//               Navigator.pop(context);
//               Navigator.pop(context);
//               _onDriverReview(context);
//             }
//         ),
//         DialogButton(
//             color: Color(0xffffc600),
//             child: Text(
//               "Cancel",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: SizeConfig.safeBlockHorizontal * 4.0),
//             ),
//             onPressed: (){
//               Navigator.pop(context);
//               Navigator.pop(context);
//             }
//         ),
//       ],
//     )
//         .show();
//   }
//
//   _onDriverReview(context) {
//     Alert(
//       context: context,
//       type: AlertType.none,
//       title: "Rider Review",
//       content:  Center(
//         child: Container(
//           decoration: BoxDecoration(
//               color: Color(0xffF4F2FF),
//               borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal*3)),
//           height: SizeConfig.safeBlockVertical * 55,
//           width: SizeConfig.safeBlockHorizontal * 70,
//           child: CustomerReviewDriver(),
//         ),
//       ),
//       buttons: [
//         DialogButton(
//             color: Color(0xffffc600),
//             child: Text(
//               "Submit",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: SizeConfig.safeBlockHorizontal * 4.0),
//             ),
//             onPressed: (){
//               Navigator.pop(context);
//               Navigator.pop(context);
//             }
//         ),
//       ],
//     )
//         .show();
//   }
//
//   _getDriverInfo(int driverID) async{
//     try{
//       Response response = await get(dbLink+'customer/driver/info/$driverID');
//       for(var temp in json.decode(response.body)){
//         driverInfoObj.add(DriverInfo.fromJson(temp));
//         _getDriverVehicleInfo(driverID);
//       }
//       Future.delayed(Duration(milliseconds: 4000),(){
//         print('driver info loaded');
//         setState(() {
//           delayInfo = false;
//           checkingID = false;
//         });
//       });
//     }
//     catch(e){
//       print('error1');
//     }
//   }
//
//   _getDriverVehicleInfo(int driverID) async{
//     try{
//       Response response =  await get(dbLink+'customer/driver/driver_transportation/$driverID');
//       for(var temp in json.decode(response.body)){
//         driverVehicleInfoObj.add(DriverVehicleInfo.fromJson(temp));
//       }
//     }
//     catch(e){
//       print('error2');
//     }
//   }
//
// //--------------------------------------------------map starts here
//   _checkGps() async {
//     if (!(await Geolocator().isLocationServiceEnabled())) {
//       if (Theme.of(context).platform == TargetPlatform.android) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("Can't get current location"),
//               content:
//               const Text('Please make sure you enable GPS and try again'),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text('Ok'),
//                   onPressed: () async {
//                     AndroidIntent intent = AndroidIntent(action: 'android.settings.LOCATION_SOURCE_SETTINGS');
//                     await intent.launch();
//                     Navigator.of(context, rootNavigator: true).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     }else{
//       _permission();
//       _setSourceAndDestinationIcons();
//       _addStaticMarkers();
//       _setInitialLocation();
//     }
//   }
//
//   _permission() async {
//     geolocationStatus = await geoLocator.checkGeolocationPermissionStatus();
//     print(geolocationStatus);
//   }
//
//   _setInitialLocation() async {
//     await geoLocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation).then((Position position){
//       initialLocation = LatLng(position.latitude, position.longitude);
//     }).then((value){
//       // _getCurrentAddressFromLatLng();
//       // _liveReceive();
//     });
//   }
//
//   _liveReceive() async{
//     subscriptionFindingID = streamFindingID.listen((data){
//     }, onDone: () {
//       print("Task Done");
//     }, onError: (error) {
//       print("Some Error");
//     });
//     while(streamControllerFindingID.hasListener) {
//       await Future.delayed(Duration(milliseconds: 2000));
//       if(!streamControllerFindingID.isClosed){
//         streamControllerFindingID.add(get(dbLink+'customer/orders/$customerID').then((value) {
//           for (var temp in json.decode(value.body)) {
//             orderDetails = (OrderDetails.fromjson(temp));
//           }
//           if(orderDetails.driverId != 0){
//             print('Driver ID Found');
//             for (var temp in json.decode(value.body)) {
//               orderDetails = (OrderDetails.fromjson(temp));
//             }
//             subscriptionFindingID.cancel();
//             streamControllerFindingID.close().then((value) async {
//               _markers.add(Marker(
//                 infoWindow: InfoWindow(title: 'Customer',snippet:'This is a just a marker'),
//                 icon: BitmapDescriptor.defaultMarkerWithHue(40.00),
//                 markerId: MarkerId('destinationPin'),
//                 position: LatLng(initialLocation.latitude, initialLocation.longitude),
//               ));
//               _markers.add(Marker(
//                   infoWindow: InfoWindow(title:'Driver',snippet:'This is a just a marker'),
//                   markerId: MarkerId('sourcePin'),
//                   position: driverLocation,
//                   icon: sourceIcon));
//               _getAddressByLatLng(driverLocation);
//               _setPolyLines(driverLocation);
//               _updateCameraPosition(driverLocation);
//
//               _getDriverInfo(orderDetails.driverId);
//             });
//           }
//           else{
//             if(delayInfo){
//               setState(() {delayInfo = false;});
//             }
//             print('Looking for Driver ID');
//           }
//         }));
//       }
//     }
//   }
//
//   _getLiveLocation() async{
//     subscriptionTracking = streamTracking.listen((data){});
//     while(streamControllerTracking.hasListener) {
//       await Future.delayed(Duration(milliseconds: 1000));
//       print(orderDetails.driverId);
//       setState(() {
//         if(calculateTime){
//           if(timeSec < 1){
//             calculateTime = false;
//           }
//           else{
//             setState(() {
//               timeSec  = timeSec - 1;
//               timeMin =  (timeSec / 60).floor();
//               remainingTimeSec = timeSec - (timeMin * 60).floor();
//             });
//           }
//         }
//
//       });
//       /*    streamControllerTracking.add(get(dbLink+'liveCus/${orderDetails.driverId}').then((value) {
//         receivedData = ReceivedData.fromjson(jsonDecode(value.body));
//         print('${receivedData.id} - ${receivedData.lat} - ${receivedData.lng}');
//       }));*/
//     }
//   }
//
//   _getCurrentAddressFromLatLng() async {
//     try {
//       List<Placemark> pList = await geoLocator.placemarkFromCoordinates(initialLocation.latitude, initialLocation.longitude);
//       Placemark placeCurrent = pList[0];
//       _currentAddress = "${placeCurrent.subThoroughfare},${placeCurrent.thoroughfare},${placeCurrent.locality},${placeCurrent.postalCode},${placeCurrent.country}";
//       print('Current Location: $_currentAddress');
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   _addStaticMarkers(){
//     try {
//       for (int i = 0; i < arrayMarkerAddress.length; i++) {
//         _getDestinationLatLngAddress(i);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   _getDestinationLatLngAddress(i) async {
//     try {
//       List<Placemark> pList = await geoLocator.placemarkFromAddress(arrayMarkerAddress[i]);
//       Placemark placeDestination = pList[0];
//       arrayMarker.add(Marker(
//           infoWindow: InfoWindow(title: 'Store ${i+1}',snippet:'This is a just a marker'),
//           icon: BitmapDescriptor.defaultMarkerWithHue(20.00),
//           markerId: MarkerId('Store ${i + 1}'),
//           position: LatLng(placeDestination.position.latitude, placeDestination.position.longitude),
//           onTap: () {
//             _getCurrentStore(arrayMarker[i].markerId.value.toString(), placeDestination.position.latitude, placeDestination.position.longitude);
//           }));
//       _markers.add(arrayMarker[i]);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   _getCurrentStore(name, lat2, lon2)  {
//     try {
//       polylineCoordinatesForClosestCurrentStore.clear();
//       polylinePoints.getRouteBetweenCoordinates(googleAPIKey, PointLatLng(currentPosition.latitude, currentPosition.longitude), PointLatLng(lat2, lon2)).then((valuePoints) {
//         if (valuePoints.points.isNotEmpty) {
//           valuePoints.points.forEach((PointLatLng point) {
//             polylineCoordinatesForClosestCurrentStore.add(LatLng(point.latitude, point.longitude));});
//           _getDistance(polylineCoordinatesForClosestCurrentStore, name);
//           polylineCoordinatesForClosestCurrentStore.clear();
//         }
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   _getClosestStore() {
//     try {
//       arrayMarker.forEach((value)  {
//         polylineCoordinatesForClosestStore.clear();
//         polylinePoints.getRouteBetweenCoordinates(googleAPIKey, PointLatLng(currentPosition.latitude, currentPosition.longitude), PointLatLng(value.position.latitude, value.position.longitude)).then((valuePoints)  {
//           if (valuePoints.points.isNotEmpty) {
//             valuePoints.points.forEach((PointLatLng point) {
//               polylineCoordinatesForClosestStore.add(LatLng(point.latitude, point.longitude));});
//             _getDistance(polylineCoordinatesForClosestStore, value.markerId.value);
//             polylineCoordinatesForClosestStore.clear();
//           }
//         });
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   _getAddressByLatLng(LatLng loc) async {
//     try {
//       List<Placemark> pList = await geoLocator.placemarkFromCoordinates(
//           loc.latitude, loc.longitude);
//       Placemark placeDestination = pList[0];
//       _destinationAddress = "${placeDestination.subThoroughfare},${placeDestination.thoroughfare},${placeDestination.locality},${placeDestination.postalCode},${placeDestination.country}";
//       destinationPosition = placeDestination.position;
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   _setPolyLines(LatLng loc)  {
//     polylineCoordinates.clear();
//     polylinePoints.getRouteBetweenCoordinates(googleAPIKey,
//         PointLatLng(initialLocation.latitude, initialLocation.longitude),
//         PointLatLng(loc.latitude, loc.longitude)).then((valuePoints) {
//       if (valuePoints.points.isNotEmpty) {
//         valuePoints.points.forEach((PointLatLng point) {
//           polylineCoordinates.add(LatLng(point.latitude, point.longitude));});
//         _getDistance(polylineCoordinates,'Destination');
//         setState(() {
//           _polyLines.add(Polyline(
//               width: 2,
//               polylineId: PolylineId("poly"),
//               color: Colors.red,
//               points: polylineCoordinates));
//         });
//       }
//     });
//   }
//
//   _updateCameraPosition(LatLng loc) async {
//     CameraPosition cPosition = CameraPosition(
//       zoom: 18,
//       tilt: CAMERA_TILT,
//       bearing: CAMERA_BEARING,
//       target: LatLng(loc.latitude, loc.longitude),
//     );
//
//     GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
//   }
//
//   _getDistance(ployPoints,markerName) async{
//     double calculateDistance = 0.0;
//     for (int i = 0; i < ployPoints.length - 1; i++) {
//       calculateDistance += _coordinateDistance(ployPoints[i].latitude, ployPoints[i].longitude, ployPoints[i + 1].latitude, ployPoints[i + 1].longitude,
//       );
//     }
//     totalDistance = calculateDistance;
//
//     timeSec = ((3600*(totalDistance*1000))/speed);
//     timeMin =  (timeSec / 60).floor();
//     remainingTimeSec = timeSec - (timeMin * 60).floor();
//     _getLiveLocation();
//     print('$markerName - DISTANCE: ${totalDistance.toStringAsFixed(2)} km');
//   }
//
//   _coordinateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }
//
//   _setSourceAndDestinationIcons() {
//     BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 1.0), 'assets/driving_pin.png')
//         .then((onValue) {
//       sourceIcon = onValue;
//     });
//     BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 1.0),
//         'assets/destination_map_marker.png')
//         .then((onValue) {
//       destinationIcon = onValue;
//     });
//
//   }
//
//   _updatePinOnMap(){
//     _circles.add(Circle(
//       circleId: CircleId('sourceCircle'),
//       center:  LatLng(currentPosition.latitude, currentPosition.longitude),
//       fillColor: Colors.black45,
//       strokeWidth: 1,
//       strokeColor: Colors.yellowAccent,
//       radius: 100,
//     ));
//
//     _markers.add(Marker(
//         markerId: MarkerId('sourcePin'),
//         position: LatLng(currentPosition.latitude, currentPosition.longitude),
//         icon: BitmapDescriptor.defaultMarkerWithHue(100.00)));
//
//     sourcePinInfo = PinInformation(
//         locationName: "$_currentAddress",
//         location: LatLng(currentPosition.latitude, currentPosition.longitude),
//         pinPath: "assets/driving_pin.png",
//         avatarPath: "assets/friend1.jpg",
//         labelColor: Colors.blueAccent);
//   }
//
//   _showPinsOnMap(LatLng loc) {
//     // add the initial source location pin
//     _markers.add(Marker(
//         markerId: MarkerId('sourcePin'),
//         position: LatLng(currentPosition.latitude, currentPosition.longitude),
//         onTap: () {
//           setState(() {
//             currentlySelectedPin = sourcePinInfo;
//             pinPillPosition = 0;
//           });
//         },
//         icon: sourceIcon));
//
//     sourcePinInfo = PinInformation(
//         locationName: "$_currentAddress",
//         location: LatLng(currentPosition.latitude, currentPosition.longitude),
//         pinPath: "assets/driving_pin.png",
//         avatarPath: "assets/friend1.jpg",
//         labelColor: Colors.blueAccent);
//
//     // destination pin
//     _markers.add(Marker(
//         markerId: MarkerId('destPin'),
//         position: LatLng(loc.latitude, loc.longitude),
//         onTap: () {
//           setState(() {
//             currentlySelectedPin = destinationPinInfo;
//             pinPillPosition = 0;
//           });
//         },
//         icon: destinationIcon));
//     // set the route lines on the map from source to destination
//     // for more info follow this tutorial
//     destinationPinInfo = PinInformation(
//         locationName: "$_destinationAddress",
//         location: LatLng(loc.latitude, loc.longitude),
//         pinPath: "assets/destination_map_marker.png",
//         avatarPath: "assets/friend2.jpg",
//         labelColor: Colors.purple);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: SizeConfig.appBarSize,
//           child: Container(
//             child: AppBar(
//               backgroundColor: Color(0xffffc600),
//               elevation: 1.0,
//               leading: Container(
//                 alignment: Alignment.center,
//                 height: SizeConfig.safeBlockVertical * 5,
//                 width: SizeConfig.safeBlockHorizontal * 100,
//                 child: GestureDetector(
//                   onTap: () async {
//                     await streamControllerFindingID.close();
//                     Navigator.of(context).pop(true);
//                   },
//                   child: Icon(
//                     Icons.arrow_back,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               title: Container(
//                 alignment: Alignment.centerLeft,
//                 height: SizeConfig.safeBlockVertical * 5,
//                 width: SizeConfig.safeBlockHorizontal * 100,
//                 child: Text(
//                   'Order Tracking',
//                   style: TextStyle(
//                     color: Color(0xff58402F),
//                     fontFamily: 'RobotoMedium',
//                     fontSize: SizeConfig.safeBlockHorizontal * 4,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: Container(
//           height: SizeConfig.safeBlockVertical * 100,
//           width: SizeConfig.safeBlockHorizontal * 100,
//           decoration: BoxDecoration(
//             color: Color(0xffF2F2FF),
//           ),
//           child: Container(
//             child: delayInfo?Container(
//               padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal*15),
//               child: Center(
//                 child: SpinKitWave(
//                   color: Color(0xffffc600),
//                   size: SizeConfig.safeBlockHorizontal * 20,
//                 ),
//               ),
//             ):Column(
//               children: <Widget>[
//                 SizedBox(
//                   height: SizeConfig.safeBlockVertical * .5,
//                 ),
//                 //driver name
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Container(
//                               alignment: Alignment.topLeft,
//                               child:checkingID?RichText(
//                                 text: TextSpan(
//                                     children: [
//                                       TextSpan(text:'Status: ',
//                                         style: TextStyle(
//                                           color: Colors.red,
//                                           fontFamily: 'RobotoMedium',
//                                           fontSize: SizeConfig.safeBlockHorizontal * 4,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       TextSpan(text:'Looking For Driver',
//                                         style: TextStyle(
//                                           color: Color(0xff58402F),
//                                           fontFamily: 'RobotoMedium',
//                                           fontSize: SizeConfig.safeBlockHorizontal * 4.0,
//                                           fontWeight: FontWeight.normal,
//                                         ),
//                                       )]
//                                 ),
//                               ): RichText(
//                                 text: TextSpan(
//                                     children: [
//                                       TextSpan(text:'${driverInfoObj[0].name} ',
//                                         style: TextStyle(
//                                           color: Colors.red,
//                                           fontFamily: 'RobotoMedium',
//                                           fontSize: SizeConfig.safeBlockHorizontal * 4,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       TextSpan(text:'is heading you way',
//                                         style: TextStyle(
//                                           color: Color(0xff58402F),
//                                           fontFamily: 'RobotoMedium',
//                                           fontSize: SizeConfig.safeBlockHorizontal * 4.0,
//                                           fontWeight: FontWeight.normal,
//                                         ),
//                                       )]
//                                 ),
//                               )
//                           ),
//                           SizedBox(
//                             height: SizeConfig.safeBlockVertical*.5,
//                           ),
//                           Container(
//                             alignment: Alignment.topLeft,
//                             child: RichText(
//                               text: TextSpan(
//                                   children: [
//                                     TextSpan(text:'Progress: ',
//                                       style: TextStyle(
//                                         color: Color(0xff58402F),
//                                         fontFamily: 'RobotoMedium',
//                                         fontSize: SizeConfig.safeBlockHorizontal * 3.5,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     TextSpan(text:'${orderDetails.orderStatus}',
//                                       style: TextStyle(
//                                         color: Colors.green,
//                                         fontFamily: 'RobotoMedium',
//                                         fontSize: SizeConfig.safeBlockHorizontal * 3.5,
//                                         fontWeight: FontWeight.normal,
//                                       ),
//                                     )
//                                   ]
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(
//                               SizeConfig.safeBlockHorizontal * 10),
//                           color: Color(0xffffffff),
//                           border: Border.all(
//                             color: Color(0xff000000),
//                             width:
//                             .5, //                   <--- border width here
//                           ),
//                         ),
//                         child: GestureDetector(
//                           onTap: () {
//                             _onBarCodeBox(context);
//                           },
//                           child: Container(
//                             height: SizeConfig.safeBlockHorizontal * 9,
//                             width: SizeConfig.safeBlockHorizontal * 9,
//                             child: Center(
//                               child: Image.asset(
//                                 'assets/images/generator.png',
//                                 width: SizeConfig.safeBlockHorizontal * 6,
//                                 height: SizeConfig.safeBlockHorizontal * 6,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           //onPressed: () => exit(0),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 //arrival time
//                 SizedBox(
//                   height: SizeConfig.safeBlockVertical * 1.5,
//                 ),
//                 //linear indicator
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                       horizontal: SizeConfig.safeBlockHorizontal * 5),
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     color: Color(0xffffffff),
//                     borderRadius: BorderRadius.circular(1000),
//                     border: Border.all(
//                       color: Color(0xff000000),
//                       width: 1, //                   <--- border width here
//                     ),
//                   ),
//                   child: LinearPercentIndicator(
//                     animation: true,
//                     lineHeight: 15.0,
//                     animationDuration: 1500,
//                     percent: checkingID? 0.0:linearBar,
//                     progressColor: Color(0xffffc600),
//                     backgroundColor: Color(0xffffffff),
//                   ),
//                 ),
//
//                 SizedBox(
//                   height: SizeConfig.safeBlockVertical * 1,
//                 ),
//                 //estimate time
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                       horizontal: SizeConfig.safeBlockHorizontal * 5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Container(
//                           child:RichText(
//                             text: TextSpan(
//                                 children: [
//                                   TextSpan(text:'Distance: ',
//                                     style: TextStyle(
//                                       color: Color(0xff58402F),
//                                       fontFamily: 'RobotoMedium',
//                                       fontSize: SizeConfig.safeBlockHorizontal * 3.5,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   TextSpan(text: checkingID?'....':'${totalDistance.toStringAsFixed(2)} km',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontFamily: 'RobotoMedium',
//                                       fontSize: SizeConfig.safeBlockHorizontal * 3.5,
//                                       fontWeight: FontWeight.normal,
//                                     ),
//                                   )
//                                 ]
//                             ),
//                           )
//                       ),
//                       Container(
//                           child:RichText(
//                             text: TextSpan(
//                                 children: [
//                                   TextSpan(text:'Estimated Time: ',
//                                     style: TextStyle(
//                                       color: Color(0xff58402F),
//                                       fontFamily: 'RobotoMedium',
//                                       fontSize: SizeConfig.safeBlockHorizontal * 3.5,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   TextSpan(text:checkingID?'....':'$timeMin min ${remainingTimeSec.toStringAsFixed(0)} sec',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontFamily: 'RobotoMedium',
//                                       fontSize: SizeConfig.safeBlockHorizontal * 3.5,
//                                       fontWeight: FontWeight.normal,
//                                     ),
//                                   )
//                                 ]
//                             ),
//                           )
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: SizeConfig.safeBlockVertical * 1,
//                 ),
//                 //map
//                 Container(
//                   height: SizeConfig.safeBlockVertical * 55,
//                   width: SizeConfig.safeBlockHorizontal * 100,
//                   child: Stack(
//                     children: <Widget>[
//                       GoogleMap(
//                           circles: _circles,
//                           myLocationEnabled: true,
//                           compassEnabled: true,
//                           tiltGesturesEnabled: false,
//                           markers: _markers,
//                           polylines: _polyLines,
//                           mapType: MapType.normal,
//                           initialCameraPosition: CameraPosition(
//                               target: initialLocation,
//                               zoom: CAMERA_ZOOM,
//                               tilt: CAMERA_TILT,
//                               bearing: CAMERA_BEARING),
//                           onMapCreated: (controller) {
//                             _controller.complete(controller);
//                           }),
//                       currentlySelectedPin.avatarPath == '' ? Container() : MapPinPillComponent(
//                           pinPillPosition: pinPillPosition,
//                           currentlySelectedPin: currentlySelectedPin),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: SizeConfig.safeBlockVertical * 1.5,
//                 ),
//                 checkingID?Container(
//                   child: Column(
//                     children: [
//                       Center(
//                         child: SpinKitFadingCircle(
//                           color: Color(0xffffc600),
//                           size: SizeConfig.safeBlockHorizontal * 20,
//                         ),
//                       ),
//                       Text('Searching...'),
//                     ],
//                   ),
//                 ):Container(
//                   margin: EdgeInsets.symmetric(
//                       horizontal: SizeConfig.safeBlockHorizontal * 5),
//                   child: Column(
//                     children: <Widget>[
//                       //car details
//                       Row(
//                         children: <Widget>[
//                           Container(
//                             width: SizeConfig.safeBlockHorizontal * 60,
//                             alignment: Alignment.topLeft,
//                             child: Column(
//                               children: <Widget>[
//                                 Container(
//                                   alignment: Alignment.topLeft,
//                                   child: RichText(
//                                     text: TextSpan(
//                                         children: [
//                                           TextSpan(text:'${driverInfoObj[0].name}',
//                                             style: TextStyle(
//                                               color: Colors.red,
//                                               fontFamily: 'RobotoMedium',
//                                               fontSize: SizeConfig.safeBlockHorizontal * 3.5,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           TextSpan(text:' is in ',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'RobotoMedium',
//                                                 fontSize: SizeConfig.safeBlockHorizontal * 3.5,
//                                                 fontWeight: FontWeight.normal
//                                             ),
//                                           ),
//                                           TextSpan(text:'${driverVehicleInfoObj[0].brand}',
//                                             style: TextStyle(
//                                               color: Colors.blue,
//                                               fontFamily: 'RobotoMedium',
//                                               fontSize: SizeConfig.safeBlockHorizontal * 3.5,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           )
//                                         ]
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: SizeConfig.safeBlockVertical*1,
//                                 ),
//                                 Container(
//                                   alignment: Alignment.topLeft,
//                                   child: RichText(
//                                     text: TextSpan(
//                                         children: [
//                                           TextSpan(text:'Vehicle Color: ',
//                                             style: TextStyle(
//                                               color: Color(0xff58402F),
//                                               fontFamily: 'RobotoMedium',
//                                               fontSize: SizeConfig.safeBlockHorizontal * 3.5,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           TextSpan(text:'${driverVehicleInfoObj[0].color}',
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontFamily: 'RobotoMedium',
//                                               fontSize: SizeConfig.safeBlockHorizontal * 3.5,
//                                               fontWeight: FontWeight.normal,
//                                             ),
//                                           )
//                                         ]
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                               child: Stack(
//                                 children: <Widget>[
//                                   Container(
//                                     margin: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal*5),
//                                     child: Container(
//                                       width: SizeConfig.safeBlockHorizontal * 30,
//                                       height: SizeConfig.safeBlockHorizontal * 13,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal*3),
//                                         image: DecorationImage(
//                                           fit: BoxFit.cover,
//                                           image: NetworkImage(driverVehicleInfoObj[0].vehicleImg.replaceAll('^', '/')),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     child: Container(
//                                       width: SizeConfig.safeBlockHorizontal * 13.5,
//                                       height: SizeConfig.safeBlockHorizontal * 13.5,
//                                       decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           border: Border.all(
//                                             color: Color(0xffffffff),
//                                             width:
//                                             2, //                   <--- border width here
//                                           ),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.grey,
//                                               offset: Offset(0.0, 1.0),
//                                               //(x,y)
//                                               blurRadius: 6.0,
//                                             ),
//                                           ],
//                                           image: DecorationImage(
//                                               fit: BoxFit.fitHeight,
//                                               image: NetworkImage(driverInfoObj[0].driverImg.replaceAll('^', '/')))),
//                                     ),
//                                   ),
//                                 ],
//                               ))
//                         ],
//                       ),
//                       //contact
//                       SizedBox(
//                         height: SizeConfig.safeBlockVertical * 1.5,
//                       ),
//                       Container(
//                           width: SizeConfig.safeBlockHorizontal * 100,
//                           height: SizeConfig.safeBlockVertical * 7,
//                           margin: EdgeInsets.only(
//                               bottom: SizeConfig.safeBlockVertical * 1),
//                           child: Row(
//                             children: <Widget>[
//                               Container(
//                                 width: SizeConfig.safeBlockHorizontal * 13,
//                                 height: SizeConfig.safeBlockHorizontal * 13,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Color(0xffffffff),
//                                   border: Border.all(
//                                     color: Color(0xffffc600),
//                                     width:
//                                     2, //                   <--- border width here
//                                   ),
//                                 ),
//                                 child: Icon(
//
//                                   Icons.phone,
//                                   size: SizeConfig.safeBlockHorizontal * 7,
//                                   color: Color(0xff58402F),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   alignment: Alignment.centerLeft,
//                                   padding: EdgeInsets.only(
//                                       left:
//                                       SizeConfig.safeBlockHorizontal * 5),
//                                   decoration: BoxDecoration(
//                                       shape: BoxShape.rectangle,
//                                       color: Color(0xffffffff),
//                                       border: Border.all(
//                                         color: Color(0xffffc600),
//                                         width:
//                                         2, //                   <--- border width here
//                                       ),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(
//                                               SizeConfig.safeBlockHorizontal *
//                                                   5))),
//                                   child: Text(
//                                     "Send a message",
//                                     style: TextStyle(
//                                       color: Color(0xff58402F),
//                                       fontFamily: 'RobotoMedium',
//                                       fontSize:
//                                       SizeConfig.safeBlockHorizontal * 4,
//                                       fontWeight: FontWeight.normal,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }
//
// final List<DriverInfo> driverInfoObj = [];
// class DriverInfo {
//   String name;
//   String driverImg;
//   String phoneNo;
//
//   DriverInfo({this.name,this.driverImg,this.phoneNo});
//
//   factory DriverInfo.fromJson(Map<String, dynamic> jsonData)=>DriverInfo(
//     name: jsonData['first_name'],
//     driverImg: jsonData['img_profile'],
//     phoneNo: jsonData['phone_no'],
//   );
// }
//
// final List<DriverVehicleInfo> driverVehicleInfoObj = [];
// class DriverVehicleInfo {
//   String brand;
//   String vehicleImg;
//   String color;
//
//   DriverVehicleInfo({this.brand,this.vehicleImg,this.color});
//
//   factory DriverVehicleInfo.fromJson(Map<String, dynamic> jsonData)=>DriverVehicleInfo(
//     brand: jsonData['brand'],
//     color: jsonData['color'],
//     vehicleImg: jsonData['img_vhl_img'],
//   );
// }
//
// class MapPinPillComponent extends StatefulWidget {
//   double pinPillPosition;
//   PinInformation currentlySelectedPin;
//
//   MapPinPillComponent({this.pinPillPosition, this.currentlySelectedPin});
//
//   @override
//   State<StatefulWidget> createState() => MapPinPillComponentState();
// }
// class MapPinPillComponentState extends State<MapPinPillComponent> {
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedPositioned(
//       bottom: widget.pinPillPosition,
//       right: 0,
//       left: 0,
//       duration: Duration(milliseconds: 200),
//       child: Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//           margin: EdgeInsets.all(20),
//           height: 70,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(50)),
//               boxShadow: <BoxShadow>[
//                 BoxShadow(
//                     blurRadius: 20,
//                     offset: Offset.zero,
//                     color: Colors.grey.withOpacity(0.5))
//               ]),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 width: 50,
//                 height: 50,
//                 margin: EdgeInsets.only(left: 10),
//                 child: ClipOval(
//                     child: Image.asset(widget.currentlySelectedPin.avatarPath,
//                         fit: BoxFit.cover)),
//               ),
//               Expanded(
//                 child: Container(
//                   margin: EdgeInsets.only(left: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(widget.currentlySelectedPin.locationName, style: TextStyle(color: widget.currentlySelectedPin.labelColor)),
//                       Text('Latitude: ${widget.currentlySelectedPin.location.latitude.toStringAsFixed(2)}', style: TextStyle(fontSize: 12, color: Colors.grey)),
//                       Text('Longitude: ${widget.currentlySelectedPin.location.longitude.toStringAsFixed(2)}', style: TextStyle(fontSize: 12, color: Colors.grey)),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class PinInformation {
//   String pinPath;
//   String avatarPath;
//   LatLng location;
//   String locationName;
//   Color labelColor;
//
//   PinInformation(
//       {this.pinPath,
//         this.avatarPath,
//         this.location,
//         this.locationName,
//         this.labelColor});
// }
//
// ReceivedData receivedData;
// class ReceivedData{
//   String id;
//   String lat;
//   String lng;
//   ReceivedData({this.id,this.lat,this.lng});
//   factory ReceivedData.fromjson(Map<String,dynamic> data)=> ReceivedData(
//       id: data['id'],
//       lat: data['latitude'],
//       lng: data['longitude']
//   );
// }
//
// OrderDetails orderDetails;
// class OrderDetails{
//   int driverId;
//   String date;
//   String time;
//   String convention;
//   String specialInstructions;
//   String QRCode;
//   String orderStatus;
//   OrderDetails({this.driverId,this.orderStatus,this.date,this.time,this.convention,this.QRCode,this.specialInstructions});
//   factory OrderDetails.fromjson(Map<String,dynamic> data)=> OrderDetails(
//     driverId: data['driver_id'],
//     date: data['prefer_date'],
//     time: data['prefer_time'],
//     convention: data['prefer_convention'],
//     specialInstructions: data['special_instruction'],
//     QRCode: data['qr_code'],
//     orderStatus: data['order_status'],
//   );
//
// }