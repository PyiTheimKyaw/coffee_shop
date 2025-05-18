import 'dart:async';

import 'package:coffee_shop/utils/colors.dart';
import 'package:coffee_shop/utils/dimens.dart';
import 'package:coffee_shop/utils/strings.dart';
import 'package:coffee_shop/widgets/customized_text_view.dart';
import 'package:flutter/foundation.dart';
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

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;

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
      if (kDebugMode) {
        print('Error getting location: $e');
      }
    }
  }

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
      for (var point in result.points) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    setMarkerIcon();

    getPolyPoints();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return _OrderStatusAndTimerView();
          },
        );
      }
    });
    super.initState();
  }

  void setMarkerIcon() {
    BitmapDescriptor.asset(
      ImageConfiguration.empty,
      "assets/images/deli.png",
      width: AppDimens.kLargeIconSize,
    ).then((val) {
      sourceIcon = val;
    });
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
                  zoom: 13,
                ),
                polylines: {
                  Polyline(
                    polylineId: PolylineId("route"),
                    points: polyLineCoordinates,
                    color: AppColors.kPrimaryColor,
                    width: 6,
                  ),
                },
                markers: {
                  // Marker(
                  //   markerId: MarkerId("currentLocation"),
                  //   position: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
                  // ),
                  Marker(markerId: MarkerId("source"), icon: sourceIcon, position: sourceLocation),
                  Marker(
                    markerId: MarkerId("destination"),
                    icon: destinationIcon,
                    position: destination,
                  ),
                },
                onMapCreated: (mapController) {
                  _controller.complete(mapController);
                },
              ),
          //Back Button
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
          Positioned(
            bottom: AppDimens.kMargin16,
            left: AppDimens.kMargin16,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return _OrderStatusAndTimerView();
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.all(AppDimens.kMargin16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimens.kRadius20),
                  color: AppColors.kWhiteColor,
                ),
                child: Icon(Icons.delivery_dining, color: AppColors.kPrimaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderStatusAndTimerView extends StatelessWidget {
  const _OrderStatusAndTimerView();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.kMargin20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimens.kMargin20),
          topRight: Radius.circular(AppDimens.kMargin20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(AppDimens.kRadius10),
            ),
          ),
          const SizedBox(height: AppDimens.kMargin20),
          CustomizedTextView(
            textData: kTextDummyDuration,
            textFontSize: AppDimens.kFont20,
            textFontWeight: FontWeight.bold,
          ),
          const SizedBox(height: AppDimens.kMargin8),
          CustomizedTextView(
            textData: kTextDummyDeliverStatus,
            textFontSize: AppDimens.kFont16,
            textFontWeight: FontWeight.w500,
            textColor: AppColors.kGreyColor,
          ),
          const SizedBox(height: AppDimens.kMargin30),
          // Progress indicator
          Row(
            children: List.generate(4, (index) {
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: index != 3 ? 5 : 0),
                  decoration: BoxDecoration(
                    color: index < 3 ? Colors.green : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: AppDimens.kMargin20),
          // Order status card
          Container(
            padding: const EdgeInsets.all(AppDimens.kRadius16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.kRadius12),
              color: Colors.white,
              border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDimens.kRadius10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimens.kRadius10),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.kWhiteColor,
                      borderRadius: BorderRadius.circular(AppDimens.kRadius12),
                    ),
                    child: const Icon(
                      Icons.delivery_dining,
                      color: AppColors.kPrimaryColor,
                      size: AppDimens.kLargeIconSize,
                    ),
                  ),
                ),
                const SizedBox(width: AppDimens.kMargin12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CustomizedTextView(
                        textData: 'Delivered your order',
                        textFontWeight: FontWeight.bold,
                        textFontSize: AppDimens.kFont16,
                      ),
                      SizedBox(height: 4),
                      CustomizedTextView(
                        textData: 'We will deliver your goods to you in the shortes possible time.',
                        textColor: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.kMargin30),
          // Courier Info
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimens.kRadius10),
                  image: DecorationImage(
                    image: NetworkImage('https://randomuser.me/api/portraits/men/31.jpg'),
                  ),
                ),
              ),
              const SizedBox(width: AppDimens.kMargin12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomizedTextView(
                      textData: 'Brooklyn Simmons',
                      textFontSize: AppDimens.kFont16,
                      textFontWeight: FontWeight.bold,
                    ),
                    CustomizedTextView(textData: 'Personal Courier', textColor: Colors.black54),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(AppDimens.kRadius10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimens.kRadius10),
                  border: Border.all(color: Colors.black12),
                ),
                child: const Icon(Icons.call, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.kMargin30),
        ],
      ),
    );
  }
}
