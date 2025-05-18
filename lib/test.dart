// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class LatLon {
//   final double lat;
//   final double lon;
//
//   LatLon({
//     required this.lat,
//     required this.lon,
//   });
// }
//
// abstract final class LatLonUtils {
//   static Future<Position?> getPosition() async {
//     final status = await Permission.location.request();
//     if (status.isGranted) {
//       return await Geolocator.getCurrentPosition(
//         locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
//       );
//     }
//     return null;
//   }
//
//   static Future<LatLon?> getLatLon() async {
//     final position = await getPosition();
//
//     if (null != position) {
//       return LatLon(lat: position.latitude, lon: position.longitude);
//     }
//
//     return null;
//   }
// }