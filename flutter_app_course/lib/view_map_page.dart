import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewMapPage extends StatefulWidget {
  const ViewMapPage({super.key});

  @override
  State<ViewMapPage> createState() => _ViewMapPageState();
}

class _ViewMapPageState extends State<ViewMapPage> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  LatLng? positionMe;
  String namePlacemark = "";

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Map',
          style: TextStyle(color: Colors.blue, fontSize: 20),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: positionMe!, zoom: 15),
        markers: {
          Marker(
              markerId: const MarkerId('loc_1'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              position: positionMe!,
              infoWindow: InfoWindow(title: namePlacemark)),
          Marker(
              markerId: const MarkerId('loc_2'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
              position: const LatLng(-6.183149922741347, 106.90945987610598),
              infoWindow: InfoWindow(title: namePlacemark))
        },
      ),
    );
  }

  Future getCurrentPosition() async {
    Position currentPosition = await _geolocatorPlatform.getCurrentPosition(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
    ));
    double lat = currentPosition.latitude;
    double longi = currentPosition.longitude;
    List<Placemark> placemark = await placemarkFromCoordinates(lat, longi);
    setState(() {
      positionMe = LatLng(currentPosition.latitude, currentPosition.longitude);
      namePlacemark = placemark.last.name ?? '-';
    });
  }
}
