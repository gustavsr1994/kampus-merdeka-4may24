import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_course/common/constant.dart';

class TrackVehicleProvider extends ChangeNotifier {
  final cron = Cron();
  bool statusTrack = false;

  void startTrackVehicle() {
    statusTrack = true;
    int index = 0;

    cron.schedule(Schedule.parse('*/1 * * * *'), () async {
      final CollectionReference collection =
          FirebaseFirestore.instance.collection('tracking');
      await collection.add({
        'create_date': DateTime.now().toString(),
        'location': GeoPoint(
            listLocation[index].latitude, listLocation[index].longitude)
      });
      index++;
    });
    while (index == listLocation.length) {
      cron.close();
      statusTrack = false;
    }

    notifyListeners();
  }

  void endTrackVehicle() {
    cron.close();
    statusTrack = false;
    notifyListeners();
  }
}
