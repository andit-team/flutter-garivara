import 'dart:async';

import 'package:andgarivara/User/view/RideResults/rideResults.dart';
import 'package:andgarivara/User/view/homeScreen/chooseLocation.dart';
import 'package:andgarivara/User/view/homeScreen/widgets/homeTopTextField.dart';
import 'package:andgarivara/User/view/homeScreen/widgets/vehicleTypes.dart';
import 'package:andgarivara/Utils/controller/userLocation.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/loader.dart';
import 'package:andgarivara/Utils/widgets/redButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Utils/appConst.dart';
import '../../../Utils/controller/SizeConfigController.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  CameraPosition initialCameraPosition;
  Set<Marker> gMarker = Set<Marker>();
  LatLng position;
  LatLng initialPosition;
  Completer<GoogleMapController> mapController = Completer();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Polyline> _polyLines = Set<Polyline>();



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
    super.build(context);
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
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        minMaxZoomPreference: MinMaxZoomPreference.unbounded,
        buildingsEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: _onMapCreated,
        markers: gMarker,
        onTap: setNewLocation,
        polylines: _polyLines,
      ),
    );
  }

  Address pickUpAddress;
  Address dropOffAddress;

  LatLng pickUp;
  LatLng dropOff;

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
                pickUpAddress = await Get.to(ChooseLocationScreen(),arguments: 'p');
                if(pickUpAddress != null){
                  pickUpLocation.text = pickUpAddress.addressLine;
                  pickUp = LatLng(pickUpAddress.coordinates.latitude, pickUpAddress.coordinates.longitude);
                  _setPolyLines(pickUp,dropOff);
                }
              },
              controller: pickUpLocation,
              prefix: Icons.my_location,
              label: 'Pick up Location',
            ),
            HomeTextField(
              onTap: () async{
                dropOffAddress = await Get.to(ChooseLocationScreen(),arguments: 'd');
                if(dropOffAddress != null){
                  dropOffLocation.text = dropOffAddress.addressLine;
                  dropOff = LatLng(dropOffAddress.coordinates.latitude, dropOffAddress.coordinates.longitude);
                  _setPolyLines(pickUp,dropOff);
                }
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
    return AnimatedPositioned(
      bottom: 0,
      duration: AppConst.duration,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Get.width,
          maxHeight: Get.height * .25
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
                  function: (){
                    Get.to(RideResults());
                  }
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
      height: sizeConfig.height * 70,
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
    pickUp = initialPosition;
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

  bool init = true;

  addMarker(LatLng location, [String s]) async{
    position = location;
    gMarker.add(Marker(
        markerId: MarkerId(s ?? 'userLocation'),
        position: location
    ));
    if(init){
      await getAddressFromLatLng(location);
      init = false;
    }
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

  setNewLocation(LatLng location) {
    setState(() {
      addMarker(location);
    });
  }

  _setPolyLines(LatLng pickUp, LatLng dropOff)  {
    if(pickUpAddress != null && dropOffAddress !=null){
      polylineCoordinates.clear();
      polylinePoints.getRouteBetweenCoordinates(DotEnv().env['google_api_key'],
          PointLatLng(pickUp.latitude, pickUp.longitude),
          PointLatLng(dropOff.latitude, dropOff.longitude)).then((valuePoints) {
        if (valuePoints.points.isNotEmpty) {
          valuePoints.points.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));});
          // _getDistance(polylineCoordinates,'Destination');
          setState(() {
            gMarker.clear();
            addMarker(pickUp,'pickUp');
            addMarker(dropOff,'dropOff');
            _polyLines.add(Polyline(
              width: 8,
              polylineId: PolylineId("poly"),
              color: AppConst.appGreen,
              points: polylineCoordinates));
          });
        }
      });
    }
  }


}
