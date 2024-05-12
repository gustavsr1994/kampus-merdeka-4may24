import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewMapPage extends StatefulWidget {
  const ViewMapPage({super.key});

  @override
  State<ViewMapPage> createState() => _ViewMapPageState();
}

class _ViewMapPageState extends State<ViewMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Map',
          style: TextStyle(color: Colors.blue, fontSize: 20),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(0.7187915531225515, 114.4563867206868), zoom: 15),
        markers: {
          Marker(
              markerId: MarkerId('loc_1'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              position: LatLng(0.7187915531225515, 114.4563867206868),
              infoWindow: InfoWindow(title: 'Kpg Lubukluu'))
        },
      ),
    );
  }
}
