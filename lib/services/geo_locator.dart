import 'dart:io';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class getLocation {
  /// Request Location permission, return GeolocationStatus object
  static Future<LocationPermission> requestPermissions() async {
    return await Geolocator.requestPermission();
  }

  /// get location status: GPS enabled and the permission status with GeolocationStatus
  // static Future<LocationStatus> checkLocationStatus() async {
  //   final status = await Geolocator.checkPermission();
  //   final enabled = await Geolocator.isLocationServiceEnabled();
  //   return LocationStatus(enabled, status);
  // }

  Future<String> getCurrentLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    print('location: ${position.latitude}');
    List<Placemark> addresses =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    var first = addresses.first;
    print("${first.name} : ${first..administrativeArea}");
    return ('${first.country}, ${first.subAdministrativeArea}, ${first.street}');
  }
}
