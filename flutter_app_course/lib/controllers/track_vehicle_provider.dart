import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_course/common/constant.dart';
import 'package:geolocator/geolocator.dart';

class TrackVehicleProvider extends ChangeNotifier {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('tracking');
  final cron = Cron();
  bool statusTrack = false;

  void startTrackVehicle() async {
    statusTrack = true;
    int index = 0;

    for (var element in listLocation) {
      final GeolocatorPlatform _geolocatorPlatform =
          GeolocatorPlatform.instance;

      if (index == 0) {
        await collection.add({
          'create_date': DateTime.now().toString(),
          'location': GeoPoint(
              listLocation[index].latitude, listLocation[index].longitude)
        });
      } else {
        var distance = _geolocatorPlatform.distanceBetween(
            listLocation[index - 1].latitude,
            listLocation[index - 1].longitude,
            listLocation[index].latitude,
            listLocation[index].longitude);
        if (distance > 500) {
          await collection.add({
            'create_date': DateTime.now().toString(),
            'location': GeoPoint(
                listLocation[index].latitude, listLocation[index].longitude)
          });
        }
      }
      index++;
    }

//? berdasarkan waktu per 1 menit
    // cron.schedule(Schedule.parse('*/1 * * * *'), () async {
    //   await collection.add({
    //     'create_date': DateTime.now().toString(),
    //     'location': GeoPoint(
    //         listLocation[index].latitude, listLocation[index].longitude)
    //   });
    //   index++;
    // });
    while (index == listLocation.length) {
      // cron.close();
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
