import 'dart:async';
import 'dart:ui';

import 'package:andgarivara/User/view/RideResults/rideResults.dart';
import 'package:andgarivara/User/view/homeScreen/chooseLocation.dart';
import 'package:andgarivara/User/view/homeScreen/widgets/homeTopTextField.dart';
import 'package:andgarivara/User/view/homeScreen/widgets/vehicleTypes.dart';
import 'package:andgarivara/User/view/reviewRideScreen.dart';
import 'package:andgarivara/Utils/controller/rideStatusController.dart';
import 'package:andgarivara/Utils/controller/userLocation.dart';
import 'package:andgarivara/Utils/enum.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/lightTextField.dart';
import 'package:andgarivara/Utils/widgets/loader.dart';
import 'package:andgarivara/Utils/widgets/wideRedButton.dart';
import 'package:andgarivara/Utils/widgets/wideWhiteButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  TextEditingController cancelReason = TextEditingController();

  bool loading = true;

  final GetSizeConfig sizeConfig = Get.find();
  GetRideStatusController rideStatusController = Get.find();
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
      // TODO delete appbar in the end
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.filter_1,color: Colors.red,),
            onPressed: (){
              rideStatusController.updateStatus(RideStatus.NONE);
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_2,color: Colors.red,),
            onPressed: (){
              rideStatusController.updateStatus(RideStatus.PROCESSING);
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_3,color: Colors.red,),
            onPressed: (){
              rideStatusController.updateStatus(RideStatus.FOUND);
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_4,color: Colors.red,),
            onPressed: (){
              rideStatusController.updateStatus(RideStatus.RUNNING);
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_5,color: Colors.red,),
            onPressed: (){
              rideStatusController.updateStatus(RideStatus.FINISHED);
            },
          ),
        ],
      ),
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: Obx(()=>Stack(
          children: [
            Stack(
              children: [
                AnimatedCrossFade(
                  duration: AppConst.duration,
                  firstChild: Loader(),
                  secondChild: googleMap(),
                  crossFadeState: loading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                ),
                chooseLocation(),
                rideStatusController.status.value == RideStatus.PROCESSING ? Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaY: 5,
                      sigmaX: 5
                    ),
                    child: Container(color: Colors.black.withOpacity(0),
                    ),
                  ),
                ) : SizedBox()
              ],
            ),
            AnimatedPositioned(
              bottom: 0,
              duration: AppConst.duration,
              child: AnimatedContainer(
                duration: AppConst.duration,
                constraints: BoxConstraints(
                  maxWidth: Get.width,
                  minWidth: Get.width,
                  // maxHeight: Get.height * .25,
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
                  child: bottomSheet(),
                ),
              ),
            ),
          ],
        )),
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
      )
    );
  }

  Address pickUpAddress;
  Address dropOffAddress;

  LatLng pickUp;
  LatLng dropOff;

  bool cancelRide = false;

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
                print('444');
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

    if(rideStatusController.status.value == RideStatus.NONE){
      return statusNone();
    }else if(rideStatusController.status.value == RideStatus.PROCESSING){
      return statusProcessing();
    }else if(rideStatusController.status.value == RideStatus.FOUND){
      return statusFound();
    }else if(rideStatusController.status.value == RideStatus.RUNNING){
      return statusRunning();
    }else{
      return statusFinished();
    }
  }

  ///   STATUS NONE
  Widget statusNone() => Padding(
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
        WideRedButton(
            label: StringResources.btnHomeSearchVehicle,
            onPressed: (){
              Get.to(RideResults());
            }
        )
      ],
    ),
  );

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

  ///   STATUS PROCESSING LOOKING FOR VEHICLE
  Widget statusProcessing() => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      SpinKitFadingCircle(
        color: Colors.grey,
      ),
      Text(
        StringResources.homeScreenRideProcessingTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: sizeConfig.getPixels(20),
          color: AppConst.textBlue
        ),
      ),
      Text(
        StringResources.homeScreenRideProcessingSubtitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: sizeConfig.getPixels(14),
          color: AppConst.textBlue
        ),
      ),
      WideRedButton(
        label: 'Cancel booking',
        onPressed: cancelRideRequest
      )
    ],
  );

  /// STATUS RIDE FOUND / CANCEL RIDE
  int selectedCancelReason;
  Widget statusFound() => Padding(
    padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AnimatedCrossFade(
          /// accept
          firstChild: Column(
            children: [
              Text(
                StringResources.homeScreenRideFoundTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sizeConfig.getPixels(20),
                  color: AppConst.textBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                color: AppConst.containerBg,
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
                child: ExpansionTile(
                  childrenPadding: EdgeInsets.zero,
                  tilePadding: EdgeInsets.zero,
                  // trailing: SizedBox(),
                  title: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                StringResources.driverImage
                            ),
                            radius: sizeConfig.getPixels(30),
                          ),
                          Icon(
                            Icons.verified_user,
                            color: AppConst.appGreen,
                          )
                        ],
                      ),
                      SizedBox(width: sizeConfig.width * 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'John Dove',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: sizeConfig.getPixels(18),
                                fontFamily: 'Robot-M',
                                color: AppConst.textBlue
                            ),
                          ),
                          Row(
                            children: [
                              RatingBar(
                                rating: 3,
                                icon:Icon(Icons.star,size:13,color: Colors.grey,),
                                starCount: 5,
                                spacing: 0.0,
                                size: 13,
                                isIndicator: false,
                                allowHalfRating: true,
                                color: AppConst.appBlue,
                              ),
                              Text(
                                '(63 Rating)',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: sizeConfig.getPixels(14),
                                    color: AppConst.textBlue
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '4.93 out of 5',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: sizeConfig.getPixels(12),
                                color: AppConst.textBlue
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              height: sizeConfig.height * 60,
                              width: sizeConfig.width * 280,
                              child: CachedNetworkImage(
                                imageUrl: 'https://cdn.pixabay.com/photo/2012/04/12/23/48/car-30990__340.png',
                                fit: BoxFit.cover,
                              )
                          ),
                          Text(
                            'Lamborghini X-100',
                            style: TextStyle(
                                fontSize: sizeConfig.getPixels(12),
                                color: AppConst.textBlue
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
                      padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
                      decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                color: Colors.grey
                            ),
                            bottom: BorderSide(
                                color: Colors.grey
                            ),
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: double.infinity,),
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              Icons.my_location_sharp,
                              color: AppConst.appRed,
                            ),
                            title: Text(
                              '61, Ahsan ahmed road, Khulna',
                              style: TextStyle(
                                color: AppConst.textBlue
                              ),
                            ),
                            subtitle: Text(
                              '10 Dec 2020 - 10:00AM',
                              style: TextStyle(
                                color: AppConst.textBlue
                              ),
                            ),
                          ),
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              Icons.my_location_sharp,
                              color: AppConst.appRed,
                            ),
                            title: Text(
                              '61, Ahsan ahmed road, Khulna',
                              style: TextStyle(
                                color: AppConst.textBlue
                              ),
                            ),
                            subtitle: Text(
                              '10 Dec 2020 - 10:00AM',
                              style: TextStyle(
                                color: AppConst.textBlue
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
                      padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment method',
                            style: TextStyle(
                                fontSize: sizeConfig.getPixels(20),
                                fontWeight: FontWeight.bold,
                                color: AppConst.textBlue
                            ),
                          ),
                          Text(
                            'Payment method',
                            style: TextStyle(
                                fontSize: sizeConfig.getPixels(16),
                                color: AppConst.textLight
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// cancel ride
          secondChild: Column(
            children: [
              SizedBox(height: sizeConfig.height * 20,),
              Text(
                StringResources.homeScreenCancelRideTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sizeConfig.getPixels(20),
                  color: AppConst.textBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                StringResources.homeScreenCancelRideSubtitle,
                style: TextStyle(
                  fontSize: sizeConfig.getPixels(16),
                  color: AppConst.textLight,
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (_, index){
                  return CheckboxListTile(
                    value: index == selectedCancelReason,
                    onChanged: (bool){
                      if(selectedCancelReason == index){
                        setState(() {
                          selectedCancelReason = 100;
                        });
                      }else{
                        setState(() {
                          selectedCancelReason = index;
                        });
                      }
                    },
                    title: Text(
                      'Cancel Reason No. ${index+1}',
                      style: TextStyle(
                          fontSize: sizeConfig.getPixels(16),
                          color: AppConst.textBlue
                      ),
                    ),
                  );
                },
              ),
              selectedCancelReason ==5 ?
              Padding(
                padding: EdgeInsets.only(bottom: sizeConfig.height * 15),
                child: LightTextField(
                  hintText: 'Please explain your reson to reject this ride...',
                  controller: cancelReason,
                  minLines: 4,
                  enabled: true,
                ),
              )
                  : SizedBox(),
            ],
          ),
          crossFadeState: cancelRide ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: AppConst.duration
        ),
        Row(
          children: [
            Expanded(
              child: WideWhiteButton(
                label: 'Cancel',
                onPressed: cancelRideRequest
              ),
            ),
            SizedBox(width: sizeConfig.width * 30,),
            Expanded(
              child: WideRedButton(
                label: cancelRide ? 'Submit' : 'Confirm',
                onPressed: (){
                  if(cancelRide){
                    cancelRide = !cancelRide;
                    rideStatusController.updateStatus(RideStatus.NONE);
                  }
                }
              ),
            ),
          ],
        )
      ],
    ),
  );

  /// STATUS RUNNING
  Widget statusRunning(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 15),
      child: Column(
        children: [
          Text(
            StringResources.homeScreenRunningRide,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: sizeConfig.getPixels(20),
              color: AppConst.textBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            color: AppConst.containerBg,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(vertical: sizeConfig.height * 20),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          StringResources.driverImage
                      ),
                      radius: sizeConfig.getPixels(30),
                    ),
                    Icon(
                      Icons.verified_user,
                      color: AppConst.appGreen,
                    )
                  ],
                ),
                SizedBox(width: sizeConfig.width * 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'John Dove',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: sizeConfig.getPixels(18),
                          fontFamily: 'Robot-M',
                          color: AppConst.textBlue
                      ),
                    ),
                    Row(
                      children: [
                        RatingBar(
                          rating: 3,
                          icon:Icon(Icons.star,size:13,color: Colors.grey,),
                          starCount: 5,
                          spacing: 0.0,
                          size: 13,
                          isIndicator: false,
                          allowHalfRating: true,
                          color: AppConst.appBlue,
                        ),
                        Text(
                          '(63 Rating)',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: sizeConfig.getPixels(14),
                              color: AppConst.textBlue
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '4.93 out of 5',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: sizeConfig.getPixels(12),
                          color: AppConst.textBlue
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: sizeConfig.height * 60,
                        width: sizeConfig.width * 280,
                        child: CachedNetworkImage(
                          imageUrl: 'https://cdn.pixabay.com/photo/2012/04/12/23/48/car-30990__340.png',
                          fit: BoxFit.cover,
                        )
                    ),
                    Text(
                      'Lamborghini X-100',
                      style: TextStyle(
                          fontSize: sizeConfig.getPixels(12),
                          color: AppConst.textBlue
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          WideRedButton(
            onPressed: (){},
            label: 'Trip Running',
          )
        ],
      ),
    );
  }

  /// STATUS FINISHED
  Widget statusFinished(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 15),
      child: Column(
        children: [
          Text(
            StringResources.homeScreenRideFinished,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: sizeConfig.getPixels(20),
              color: AppConst.textBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.zero,
              tilePadding: EdgeInsets.zero,
              initiallyExpanded: true,
              trailing: SizedBox(),
              title: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            StringResources.driverImage
                        ),
                        radius: sizeConfig.getPixels(30),
                      ),
                      Icon(
                        Icons.verified_user,
                        color: AppConst.appGreen,
                      )
                    ],
                  ),
                  SizedBox(width: sizeConfig.width * 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'John Dove',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: sizeConfig.getPixels(18),
                            fontFamily: 'Robot-M',
                            color: AppConst.textBlue
                        ),
                      ),
                      Row(
                        children: [
                          RatingBar(
                            rating: 3,
                            icon:Icon(Icons.star,size:13,color: Colors.grey,),
                            starCount: 5,
                            spacing: 0.0,
                            size: 13,
                            isIndicator: false,
                            allowHalfRating: true,
                            color: AppConst.appBlue,
                          ),
                          Text(
                            '(63 Rating)',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: sizeConfig.getPixels(14),
                                color: AppConst.textBlue
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '4.93 out of 5',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: sizeConfig.getPixels(12),
                            color: AppConst.textBlue
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: sizeConfig.height * 60,
                          width: sizeConfig.width * 280,
                          child: CachedNetworkImage(
                            imageUrl: 'https://cdn.pixabay.com/photo/2012/04/12/23/48/car-30990__340.png',
                            fit: BoxFit.cover,
                          )
                      ),
                      Text(
                        'Lamborghini X-100',
                        style: TextStyle(
                            fontSize: sizeConfig.getPixels(12),
                            color: AppConst.textBlue
                        ),
                      )
                    ],
                  ),
                ],
              ),
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
                  decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: Colors.grey
                        ),
                        bottom: BorderSide(
                            color: Colors.grey
                        ),
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: double.infinity,),
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.my_location_sharp,
                          color: AppConst.appRed,
                        ),
                        title: Text(
                          '61, Ahsan ahmed road, Khulna',
                          style: TextStyle(
                              color: AppConst.textBlue
                          ),
                        ),
                        subtitle: Text(
                          '10 Dec 2020 - 10:00AM',
                          style: TextStyle(
                              color: AppConst.textBlue
                          ),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.my_location_sharp,
                          color: AppConst.appRed,
                        ),
                        title: Text(
                          '61, Ahsan ahmed road, Khulna',
                          style: TextStyle(
                              color: AppConst.textBlue
                          ),
                        ),
                        subtitle: Text(
                          '10 Dec 2020 - 10:00AM',
                          style: TextStyle(
                              color: AppConst.textBlue
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: double.infinity,),
                      Text(
                        'Trip fare',
                        style: TextStyle(
                            fontSize: sizeConfig.getPixels(20),
                            fontFamily: 'Roboto-M',
                            color: AppConst.textBlue
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Payment method: ',
                            style: TextStyle(
                                fontSize: sizeConfig.getPixels(16),
                                color: AppConst.textLight
                            ),
                          ),
                          Text(
                            'Card',
                            style: TextStyle(
                                fontSize: sizeConfig.getPixels(16),
                                color: AppConst.textBlue
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sizeConfig.height  *15,),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount: ',
                            style: TextStyle(
                                fontSize: sizeConfig.getPixels(16),
                                color: AppConst.textLight
                            ),
                          ),
                          Text(
                            'BDT 8856.55',
                            style: TextStyle(
                                fontSize: sizeConfig.getPixels(16),
                                color: AppConst.textBlue
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Commission: ',
                              style: TextStyle(
                                  fontSize: sizeConfig.getPixels(16),
                                  color: AppConst.textLight
                              ),
                            ),
                            Text(
                              'BDT 856.55',
                              style: TextStyle(
                                  fontSize: sizeConfig.getPixels(16),
                                  color: AppConst.textBlue
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Grand Total: ',
                            style: TextStyle(
                                fontSize: sizeConfig.getPixels(18),
                                color: AppConst.textBlue
                            ),
                          ),
                          Text(
                            'BDT 8000.00',
                            style: TextStyle(
                                fontSize: sizeConfig.getPixels(18),
                                color: AppConst.textBlue
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(ReviewRideScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: sizeConfig.height * 15),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: Colors.grey
                        ),
                      )
                    ),
                    margin: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: double.infinity,),
                        Text(
                          StringResources.homeScreenRideFinishedReviewTitle,
                          style: TextStyle(
                              fontSize: sizeConfig.getPixels(20),
                              fontFamily: 'Roboto-M',
                              color: AppConst.textBlue
                          ),
                        ),
                        Text(
                          StringResources.homeScreenRideFinishedReviewSubtitle,
                          style: TextStyle(
                            fontSize: sizeConfig.getPixels(16),
                            color: AppConst.textLight
                          ),
                        ),
                        SizedBox(height: sizeConfig.height  *15,),
                        Center(
                          child: IgnorePointer(
                            ignoring: true,
                            child: RatingBar(
                              rating: 5,
                              icon:Icon(Icons.star,size:25,color: Colors.grey,),
                              starCount: 5,
                              spacing: 5.0,
                              size: 25,
                              isIndicator: false,
                              allowHalfRating: true,
                              color: AppConst.appBlue,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
    if(pickUp != null && dropOff != null) {
      var minLat;
      var maxLat;
      var minLng;
      var maxLng;

      if(pickUp.latitude > dropOff.latitude){
        minLat = dropOff.latitude;
        maxLat = pickUp.latitude;
      }else{
        maxLat = dropOff.latitude;
        minLat = pickUp.latitude;
      }

      if(pickUp.longitude > dropOff.longitude){
        minLng = dropOff.longitude;
        maxLng = pickUp.longitude;
      }else{
        maxLng = dropOff.longitude;
        minLng = pickUp.longitude;
      }

      Future.delayed(
          Duration(milliseconds: 200),
              () => controller.animateCamera(CameraUpdate.newLatLngBounds(
              LatLngBounds(
                southwest: LatLng(minLat, minLng),
                northeast: LatLng(maxLat, maxLng),
              ),
              100
          )));
    }else{
      controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    }
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
              startCap: Cap.roundCap,
              endCap: Cap.roundCap,
              polylineId: PolylineId("poly"),
              color: AppConst.appGreen,
              points: polylineCoordinates));
          });
        }
      });
    }
  }







  cancelRideRequest(){
    setState(() {
      cancelRide = !cancelRide;
    });
  }
}
