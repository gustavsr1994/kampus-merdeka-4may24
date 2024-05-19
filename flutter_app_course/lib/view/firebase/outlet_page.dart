import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_course/main.dart';
import 'package:flutter_app_course/view/firebase/detail_outlet_page.dart';
import 'package:flutter_app_course/view/firebase/form_edit_outlet_page.dart';
import 'package:flutter_app_course/view/firebase/form_insert_outlet_page.dart';
import 'package:flutter_app_course/view/firebase/login_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OutletPage extends StatefulWidget {
  final String? uid;
  const OutletPage({@required this.uid, super.key});

  @override
  State<OutletPage> createState() => _OutletPageState();
}

class _OutletPageState extends State<OutletPage> {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('outlet');
  bool isMaps = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome, ${widget.uid}. Daftar Outlet',
          style: TextStyle(color: Colors.blue, fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isMaps = !isMaps;
                });
              },
              icon: Icon(isMaps ? Icons.list_alt : Icons.map_sharp)),
          IconButton(
              onPressed: () async {
                SharedPreferences _sharedPref =
                    await SharedPreferences.getInstance();
                await _sharedPref.remove('uid');
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormInsertOutletPage(),
            )),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
          stream: _collection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (isMaps) {
                var listOutlet = snapshot.data!.docs;
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(listOutlet.last['location'].latitude,
                          listOutlet.last['location'].longitude),
                      zoom: 15),
                  markers: {
                    for (var element in listOutlet)
                      Marker(
                          markerId: MarkerId(element['name']),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed),
                          position: LatLng(element['location'].latitude,
                              element['location'].longitude),
                          infoWindow: InfoWindow(title: element['name']))
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var dataOutlet = snapshot.data!.docs[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataOutlet['name'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dataOutlet['hour_operation'],
                              style: TextStyle(fontSize: 17),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () async => await _collection
                                        .doc(dataOutlet.id)
                                        .delete(),
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                                IconButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FormEditOutletPage(
                                          dataOutlet: dataOutlet,
                                        ),
                                      )),
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailOutletPage(
                                            dataOutlet: dataOutlet,
                                          ),
                                        )),
                                    icon: Icon(
                                      Icons.visibility,
                                      color: Colors.green,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            } else {
              return Center(
                child: Text('No Data'),
              );
            }
          }),
    );
  }
}
