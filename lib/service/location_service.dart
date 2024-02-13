
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationService {
  Future<String> getLocation() async {
    final Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    final List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks.first.locality ?? "Unknown";
  }
}