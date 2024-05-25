// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FormInsertOutletPage extends StatefulWidget {
  const FormInsertOutletPage({super.key});

  @override
  State<FormInsertOutletPage> createState() => _FormInsertOutletPageState();
}

class _FormInsertOutletPageState extends State<FormInsertOutletPage> {
  TextEditingController nameOutletController = TextEditingController();
  TextEditingController hourOpsController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  bool isCash = false;
  bool isCashless = false;
  bool isCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Insert Outlet',
          style: TextStyle(color: Colors.blue, fontSize: 20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Nama Outlet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextFormField(
              controller: nameOutletController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Tolong isi field ini';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))))),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Jam Operational',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextFormField(
              controller: hourOpsController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Tolong isi field ini';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))))),
          const Text(
            'Latitude',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextFormField(
              controller: latitudeController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Tolong isi field ini';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))))),
          const Text(
            'Longitude',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextFormField(
              controller: longitudeController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Tolong isi field ini';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))))),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Payment',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          CheckboxListTile(
            value: isCash,
            onChanged: (value) {
              setState(() {
                isCash = value!;
              });
            },
            title: const Text('Cash'),
          ),
          CheckboxListTile(
            value: isCashless,
            onChanged: (value) {
              setState(() {
                isCashless = value!;
              });
            },
            title: const Text('Cashless'),
          ),
          CheckboxListTile(
            value: isCard,
            onChanged: (value) {
              setState(() {
                isCard = value!;
              });
            },
            title: const Text('Debit/Credit Card'),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, elevation: 5),
            onPressed: () => processSubmit(),
            child: const Text("Submit",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future processSubmit() async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('outlet');
    await collection.add({
      'name': nameOutletController.text,
      'hour_operation': hourOpsController.text,
      'payment': {'card': isCard, 'cashless': isCashless, 'cash': isCash},
      'location': GeoPoint(double.parse(latitudeController.text),
          double.parse(longitudeController.text))
    });
    Navigator.pop(context);
  }
}
