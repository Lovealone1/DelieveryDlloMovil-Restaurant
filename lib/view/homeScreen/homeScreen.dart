import 'dart:async';
import 'dart:convert';

import 'package:covefood_domiciliario/constant/constant.dart';
import 'package:covefood_domiciliario/controller/services/geoFireServices/geofireServices.dart';
import 'package:covefood_domiciliario/controller/services/locationServices/locationServices.dart';
import 'package:covefood_domiciliario/controller/services/orderServices/orderServices.dart';
import 'package:covefood_domiciliario/model/driverModel/driverModel.dart';
import 'package:covefood_domiciliario/model/foodOrderModel.dart';
import 'package:covefood_domiciliario/utils/colors.dart';
import 'package:covefood_domiciliario/utils/textStyles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(6.2529, -75.5646),
    zoom: 14,
  );
  static DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('Driver/${auth.currentUser!.uid}');
  Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? mapController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            height: 10.h,
            width: 100.w,
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
              vertical: 2.h,
            ),
            child: StreamBuilder(
              stream: databaseReference.onValue,
              builder: (context, event) {
                if (event.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: black,
                  ));
                }
                if (event.data != null) {
                  DriverModel driverData = DriverModel.fromMap(
                      jsonDecode(jsonEncode(event.data!.snapshot.value))
                          as Map<String, dynamic>);
                  if (driverData.driverStatus == 'ONLINE') {
                    return SwipeButton(
                      thumbPadding: EdgeInsets.all(1.w),
                      thumb: Icon(
                        Icons.chevron_right,
                        color: white,
                      ),
                      inactiveThumbColor: black,
                      activeThumbColor: black,
                      inactiveTrackColor: greyShade3,
                      activeTrackColor: greyShade3,
                      elevationThumb: 2,
                      elevationTrack: 2,
                      onSwipe: () {
                        GeofireServices.goOffline();
                      },
                      child: Text(
                        'Suficiente por hoy',
                        style: AppTextStyles.body14Bold,
                      ),
                    );
                  } else {
                    return SwipeButton(
                      thumbPadding: EdgeInsets.all(1.w),
                      thumb: Icon(
                        Icons.chevron_right,
                        color: white,
                      ),
                      inactiveThumbColor: black,
                      activeThumbColor: black,
                      inactiveTrackColor: greyShade3,
                      activeTrackColor: greyShade3,
                      elevationThumb: 2,
                      elevationTrack: 2,
                      onSwipe: () {
                        GeofireServices.goOnline();
                        GeofireServices.updateLocationRealtime(context);
                      },
                      child: Text(
                        'Empezar!',
                        style: AppTextStyles.body14Bold,
                      ),
                    );
                  }
                }
                return Center(
                    child: CircularProgressIndicator(
                  color: black,
                ));
              },
            ),
          ),
          StreamBuilder(
              stream: databaseReference.onValue,
              builder: (context, event) {
                if (event.data != null) {
                  DriverModel driverData = DriverModel.fromMap(
                      jsonDecode(jsonEncode(event.data!.snapshot.value))
                          as Map<String, dynamic>);
                  if (driverData.activeDelieveryRequestID != null) {
                    return StreamBuilder(
                      stream: FirebaseDatabase.instance
                          .ref()
                          .child(
                              'Orders/${driverData.activeDelieveryRequestID}')
                          .onValue,
                      builder: (context, foodOrderEvent) {
                        if (foodOrderEvent.data != null) {
                          FoodOrderModel foodOrderData = FoodOrderModel.fromMap(
                              jsonDecode(jsonEncode(
                                      foodOrderEvent.data!.snapshot.value))
                                  as Map<String, dynamic>);
                              return Builder(builder: (context){
                                if(foodOrderData.orderStatus == OrderServices.orderStatus(0)){
                                  return Expanded(
                      child: GoogleMap(
                        initialCameraPosition: initialCameraPosition,
                        mapType: MapType.normal,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        zoomControlsEnabled: true,
                        zoomGesturesEnabled: true,
                        onMapCreated: (GoogleMapController controller) async {
                          googleMapController.complete(controller);
                          mapController = controller;
                          Position currentPosition =
                              await LocationServices.getCurrentLocation();
                          LatLng currentLatLong = LatLng(
                            currentPosition.latitude,
                            currentPosition.longitude,
                          );
                          CameraPosition cameraPosition = CameraPosition(
                            target: currentLatLong,
                            zoom: 14,
                          );
                          mapController!.animateCamera(
                              CameraUpdate.newCameraPosition(cameraPosition));
                        },
                      ),
                    );
                                }else{
                                  return Expanded(
                      child: GoogleMap(
                        initialCameraPosition: initialCameraPosition,
                        mapType: MapType.normal,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        zoomControlsEnabled: true,
                        zoomGesturesEnabled: true,
                        onMapCreated: (GoogleMapController controller) async {
                          googleMapController.complete(controller);
                          mapController = controller;
                          Position currentPosition =
                              await LocationServices.getCurrentLocation();
                          LatLng currentLatLong = LatLng(
                            currentPosition.latitude,
                            currentPosition.longitude,
                          );
                          CameraPosition cameraPosition = CameraPosition(
                            target: currentLatLong,
                            zoom: 14,
                          );
                          mapController!.animateCamera(
                              CameraUpdate.newCameraPosition(cameraPosition));
                        },
                      ),
                    );
                                }
                              });
                        } else {
                          return Center(
                            child: CircularProgressIndicator(color: black),
                          );
                        }
                      },
                    );
                  } else {
                    return Expanded(
                      child: GoogleMap(
                        initialCameraPosition: initialCameraPosition,
                        mapType: MapType.normal,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        zoomControlsEnabled: true,
                        zoomGesturesEnabled: true,
                        onMapCreated: (GoogleMapController controller) async {
                          googleMapController.complete(controller);
                          mapController = controller;
                          Position currentPosition =
                              await LocationServices.getCurrentLocation();
                          LatLng currentLatLong = LatLng(
                            currentPosition.latitude,
                            currentPosition.longitude,
                          );
                          CameraPosition cameraPosition = CameraPosition(
                            target: currentLatLong,
                            zoom: 14,
                          );
                          mapController!.animateCamera(
                              CameraUpdate.newCameraPosition(cameraPosition));
                        },
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: black,
                    ),
                  );
                }
              }),
        ],
      )),
    );
  }
}
