import 'dart:async';

import 'package:coffee_shop/utils/colors.dart';
import 'package:coffee_shop/utils/dimens.dart';
import 'package:coffee_shop/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const sourceLocation = LatLng(13.67247688450588, 100.45922051955199);
  static const destination = LatLng(13.669556176057114, 100.45199498602693);
  List<LatLng> polyLineCoordinates = [];
  final Location _location = Location();
  LocationData? _currentLocation;

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if service is enabled
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    // Check permissions
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    // Get initial location
    try {
      final locationData = await _location.getLocation();
      setState(() {
        _currentLocation = locationData;
      });

      // Move the map camera to the current location
      final GoogleMapController mapController = await _controller.future;
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(locationData.latitude!, locationData.longitude!), zoom: 15),
        ),
      );

      // Listen to location updates
      _location.onLocationChanged.listen((newLocation) {
        setState(() {
          _currentLocation = newLocation;
        });
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(newLocation.latitude!, newLocation.longitude!), zoom: 15),
          ),
        );
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  // void getCurrentLocation() async {
  //   Location location = Location();
  //   try{
  //   currentLocation =await location.getLocation();}catch(e){
  //     print("Location error => $e");
  //   }
  //   GoogleMapController googleMapController = await _controller.future;
  //   location.onLocationChanged.listen((newLoc) {
  //     currentLocation = newLoc;
  //     googleMapController.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(zoom: 13.5, target: LatLng(newLoc.latitude!, newLoc.longitude!)),
  //       ),
  //     );
  //     setState(() {});
  //   });
  // }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        destination: PointLatLng(destination.latitude, destination.longitude),
        mode: TravelMode.driving,
      ),
      googleApiKey: kGoogleApiKey,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polyLineCoordinates.add(LatLng(point.latitude, point.longitude)),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    getPolyPoints();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          (_currentLocation == null)
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  // target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
                  target: sourceLocation,
                  zoom: 13.5,
                ),
                polylines: {
                  Polyline(
                    polylineId: PolylineId("route"),
                    points: polyLineCoordinates,
                    color: AppColors.kPrimaryColor,
                    width: 10,
                  ),
                },
                markers: {
                  // Marker(
                  //   markerId: MarkerId("currentLocation"),
                  //   position: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
                  // ),
                  Marker(markerId: MarkerId("source"), position: sourceLocation),
                  Marker(markerId: MarkerId("destination"), position: destination),
                },
                onMapCreated: (mapController) {
                  _controller.complete(mapController);
                },
              ),
          Positioned(
            top: kToolbarHeight,
            left: 15,
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Container(
                padding: EdgeInsets.all(AppDimens.kMargin16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimens.kRadius20),
                  color: Color.fromRGBO(237, 237, 237, 1.0),
                ),
                child: Center(child: Icon(Icons.arrow_back_ios_new_outlined)),
              ),
            ),
          ),
          // Custom Location Button
          Positioned(
            top: kToolbarHeight,
            right: 15,
            child: GestureDetector(
              onTap: () {
                ///TODO: implement to move current location
              },
              child: Container(
                padding: EdgeInsets.all(AppDimens.kMargin16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimens.kRadius20),
                  color: Color.fromRGBO(237, 237, 237, 1.0),
                ),
                child: Center(child: Icon(Icons.my_location)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
