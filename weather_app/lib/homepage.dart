// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum City {
  lagos,
  ondo,
  ibadan,
}

typedef WeatherEmoji = String;
Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
      Duration(seconds: 1),
      () => {
            City.lagos: "🌞",
            City.ondo: "💦",
            City.ibadan: "🌟",
          }[city]!);
}

//will be changed by the ui
//ui writes to this and reads from this
final currentCityProvider = StateProvider<City?>((ref) => null);

//listen to changes that happen to the ui
// ui reads this
const unknownWeatherEmoji = '🙄';
final weatherProvider = FutureProvider<WeatherEmoji>(
  (ref) {
    final city = ref.watch(currentCityProvider);
    if (city != null) {
      return getWeather(city);
    } else {
      return unknownWeatherEmoji;
    }
  },
);

class Homepage extends ConsumerWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Weather App"),
        ),
        body: Column(
          children: [
            currentWeather.when(
              data: (data) => Text(
                data,
                style: TextStyle(fontSize: 40),
              ),
              error: (error, stackTrace) => Center(child: Text("Error 😭")),
              loading: () => Center(child: CircularProgressIndicator()),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: City.values.length,
                  itemBuilder: (context, ind) {
                    final city = City.values[ind];
                    final isSelected = city == ref.watch(currentCityProvider);
                    return ListTile(
                      title: Text(city.toString()),
                      trailing: isSelected ? Icon(Icons.check) : null,
                      onTap: () {
                        ref.read(currentCityProvider.notifier).state = city;
                      },
                    );
                  }),
            )
          ],
        ));
  }
}
