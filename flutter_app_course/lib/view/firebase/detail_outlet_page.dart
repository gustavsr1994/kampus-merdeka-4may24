import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
          )
        ],
      ),
    );
  }

  Widget listPayment(Map<String, dynamic> payment) {
    return Text('Payment : ${payment['cashless']?'Cashless':''},${payment['card']?'Debit/CC':''},${payment['cash']?'Cash':''}');
  }
}
