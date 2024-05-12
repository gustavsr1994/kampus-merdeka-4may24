import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailOutletPage extends StatelessWidget {
  QueryDocumentSnapshot dataOutlet;
  DetailOutletPage({required this.dataOutlet, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Outlet',
          style: TextStyle(color: Colors.blue, fontSize: 20),
        ),
      ),
      body: ListView(
        children: [
          Card(
            child: Text('Nama Outlet : ${dataOutlet['name']}'),
          ),
          Card(
            child: Text('Jam Operational : ${dataOutlet['hour_operation']}'),
          ),
          Card(
            child: listPayment(dataOutlet['payment']),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.sizeOf(context).width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(dataOutlet['location'].latitude,
                      dataOutlet['location'].longitude),
                  zoom: 15),
              markers: {
                Marker(
                    markerId: MarkerId(dataOutlet['name']),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                    position: LatLng(dataOutlet['location'].latitude,
                        dataOutlet['location'].longitude),
                    infoWindow: InfoWindow(title: dataOutlet['name']))
              },
            ),
          )
        ],
      ),
    );
  }

  Widget listPayment(Map<String, dynamic> payment) {
    return Text(
        'Payment : ${payment['cashless'] ? 'Cashless' : ''},${payment['card'] ? 'Debit/CC' : ''},${payment['cash'] ? 'Cash' : ''}');
  }
}
