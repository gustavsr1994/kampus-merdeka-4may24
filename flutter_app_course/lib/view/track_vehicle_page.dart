import 'package:flutter/material.dart';
import 'package:flutter_app_course/common/style.dart';
import 'package:flutter_app_course/controllers/track_vehicle_provider.dart';
import 'package:provider/provider.dart';

import '../common/widget/button_custom.dart';

class TrackVehiclePage extends StatefulWidget {
  const TrackVehiclePage({super.key});

  @override
  State<TrackVehiclePage> createState() => _TrackVehiclePageState();
}

class _TrackVehiclePageState extends State<TrackVehiclePage> {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<TrackVehicleProvider>();
    return Scaffold(
        body: Center(
      child: ButtonCustom(
        () => provider.statusTrack
            ? context.read<TrackVehicleProvider>().endTrackVehicle()
            : context.read<TrackVehicleProvider>().startTrackVehicle(),
        provider.statusTrack ? 'End' : 'Start',
        provider.statusTrack ? Colors.red : greenColor,
      ),
    ));
  }
}
