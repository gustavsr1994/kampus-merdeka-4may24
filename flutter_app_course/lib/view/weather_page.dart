import 'package:flutter/material.dart';
import 'package:flutter_app_course/common/style.dart';
import 'package:provider/provider.dart';

import '../common/widget/button_custom.dart';
import '../controllers/weather_provider.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    var weatherProvider = context.watch<WeatherProvider>();

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: TextField(
                controller: weatherProvider.nameCityField,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () =>
                            context.read<WeatherProvider>().getWeather(),
                        icon: Icon(Icons.search))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ButtonCustom(
                  () => context.read<WeatherProvider>().getWeather(), 'Search', blueColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ButtonCustom(
                  () => print('object'), 'Clear', greenColor),
            ),
            bodyWeather(weatherProvider)
          ],
        ),
      ),
    );
  }

  Widget bodyWeather(WeatherProvider provider) {
    switch (provider.state) {
      case WeatherState.loading:
        return CircularProgressIndicator();
      case WeatherState.error:
        return Text(provider.messageError);
      case WeatherState.success:
        return Center(
            child: Column(
          children: [
            Text(provider.dataWeather!.nameRegion,
                style: largeText(Colors.orange, fontWeight: true)),
            Image.network(provider.dataWeather!.iconCondition),
            Text(provider.dataWeather!.condition),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('Temp (C)',
                        style: mediumText(blueColor, fontWeight: true)),
                    Text(
                      provider.dataWeather!.temperatur.toString(),
                      style: smallText(Colors.black),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('UV', style: mediumText(greenColor, fontWeight: true)),
                    Text(
                      provider.dataWeather!.uv.toString(),
                      style: smallText(
                        Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
      default:
        return SizedBox();
    }
  }
}
