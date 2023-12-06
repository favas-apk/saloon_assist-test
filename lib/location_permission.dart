/* import 'package:geolocator/geolocator.dart';

class LocationPermissions {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location Service not Enabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission disabled");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("location Permission Denied Forever");
    } else {
      return await Geolocator.getLastKnownPosition() ??
          await Geolocator.getCurrentPosition();
    }
  }
}
 */