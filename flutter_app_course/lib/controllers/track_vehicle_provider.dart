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
      print(listLocation[index]);
      index++;
    });
    while (index > listLocation.length) {
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
