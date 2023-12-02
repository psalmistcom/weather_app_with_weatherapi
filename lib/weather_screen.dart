import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forcast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "London";
      final res = await http.get(
        //create a file called secrets and add a const called "openWeatherAPIKey"
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherAPIKey'),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        // throw data['message']; //message from API
        throw "An Internal server error occured";
      }

      return data;
    } catch (e) {
      throw e.toString();
    }

    // print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.hasData) {}
          final data = snapshot.data!;

          final currentWeatherData = data['list'][0];

          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];

          final currentPressure = currentWeatherData['main']['pressure'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // big banner
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10,
                            sigmaY: 10,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  "$currentTemp °K",
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Icon(
                                  currentSky == 'Clouds' || currentSky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 64,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "$currentSky",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Weather forcast
                  const Text(
                    "Hourly Forcast",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const SizedBox(height: 2),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for (int i = 0; i < 35; i++)
                  //         HourlyForcastitem(
                  //           time: data['list'][i + 1]['dt'].toString(),
                  //           value:
                  //               data['list'][i + 1]['main']['temp'].toString(),
                  //           icon: data['list'][i + 1]['weather'][0]['main'] ==
                  //                       "Clouds" ||
                  //                   data['list'][i + 1]['weather'][0]['main'] ==
                  //                       "Rain"
                  //               ? Icons.cloud
                  //               : Icons.sunny,
                  //         ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 35,
                      itemBuilder: (context, index) {
                        final hourlyForcast = data['list'][index + 1];
                        final hourlyForcastIcon =
                            hourlyForcast['weather'][0]['main'];
                        final time =
                            DateTime.parse(hourlyForcast['dt_txt'].toString());
                        return HourlyForcastitem(
                          time: DateFormat.Hm().format(time),
                          value: hourlyForcast['main']['temp'].toString(),
                          icon: hourlyForcastIcon == "Clouds" ||
                                  hourlyForcastIcon == "Rain"
                              ? Icons.cloud
                              : Icons.sunny,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Additional Infos
                  const Text(
                    "Additional Information",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AddtionalInfoItem(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: currentHumidity.toString(),
                      ),
                      AddtionalInfoItem(
                        icon: Icons.air,
                        label: "Wind Speed",
                        value: currentWindSpeed.toString(),
                      ),
                      AddtionalInfoItem(
                        icon: Icons.beach_access,
                        label: "Pressure",
                        value: currentPressure.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    // return const ;
  }
}
