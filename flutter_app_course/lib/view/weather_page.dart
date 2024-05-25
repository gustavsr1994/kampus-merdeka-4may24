import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            Text(
              provider.dataWeather!.nameRegion,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
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
                    Text('Temp (C)', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    Text(provider.dataWeather!.temperatur.toString()),
                  ],
                ),
                Column(
                  children: [
                    Text('UV', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    Text(provider.dataWeather!.uv.toString()),
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
