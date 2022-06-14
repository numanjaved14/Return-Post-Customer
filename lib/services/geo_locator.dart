import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class getLocation {
  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('location: ${position.latitude}');
    List<Placemark> addresses =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    var first = addresses.first;
    print("${first.name} : ${first..administrativeArea}");
  }
}
