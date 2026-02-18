import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

//chek location fr=etach success or Faluer
class LocationResult {
  final Position? position;
  final String? address;
  final String? error;

  LocationResult({this.position, this.address, this.error});

  //getter cheak error
  bool get hasError => error != null;
}

class LocationService {
  Future<LocationResult> getLocation() async {
    //cheak location services
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationResult(
        position: null,
        error: 'Location services are disabled',
      );
    }
    //cheak permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationResult(
          position: null,
          error: 'Location permissions are denied',
        );
      }
    }
    //cheak permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return LocationResult(
        position: null,
        error:
            'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    //get current location
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      );
      //get address from location
      String address = await _getAddressFromLatLng(position);


      return LocationResult(position: position, error: null,address: address);
    } catch (e) {
      return LocationResult(position: null, error: e.toString());
    }
  }

  //valid adress from location lat lon
  Future<String> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        //get first place from placemark
        Placemark place = placemarks[0];
        return "${place.street ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}";
      } else {
        return "Lat: ${position.latitude.toStringAsFixed(2)}, Lng: ${position.longitude.toStringAsFixed(2)}";
      }
    } catch (e) {
      return "Lat: ${position.latitude.toStringAsFixed(2)}, Lng: ${position.longitude.toStringAsFixed(2)}";

    }
  }
}
