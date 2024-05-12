import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FormEditOutletPage extends StatefulWidget {
  QueryDocumentSnapshot dataOutlet;
  FormEditOutletPage({required this.dataOutlet, super.key});

  @override
  State<FormEditOutletPage> createState() => _FormEditOutletPageState();
}

class _FormEditOutletPageState extends State<FormEditOutletPage> {
  TextEditingController nameOutletController = TextEditingController();
  TextEditingController hourOpsController = TextEditingController();
  bool isCash = false;
  bool isCashless = false;
  bool isCard = false;
  @override
  void initState() {
    super.initState();
    nameOutletController.text = widget.dataOutlet['name'];
    hourOpsController.text = widget.dataOutlet['hour_operation'];
    isCash = widget.dataOutlet['payment']['cash'];
    isCashless = widget.dataOutlet['payment']['cashless'];
    isCard = widget.dataOutlet['payment']['card'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Update Outlet',
          style: TextStyle(color: Colors.blue, fontSize: 20),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
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
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
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
            title: Text('Cash'),
          ),
          CheckboxListTile(
            value: isCashless,
            onChanged: (value) {
              setState(() {
                isCashless = value!;
              });
            },
            title: Text('Cashless'),
          ),
          CheckboxListTile(
            value: isCard,
            onChanged: (value) {
              setState(() {
                isCard = value!;
              });
            },
            title: Text('Debit/Credit Card'),
          ),
          SizedBox(
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
    final CollectionReference _collection =
        FirebaseFirestore.instance.collection('outlet');
    await _collection.doc(widget.dataOutlet.id).update({
      'name': nameOutletController.text,
      'hour_operation': hourOpsController.text,
      'payment': {'card': isCard, 'cashless': isCashless, 'cash': isCash}
    });
    Navigator.pop(context);
  }
}
