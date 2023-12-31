import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
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
  double temp = 0;

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    try {
      String cityName = "London";
      final res = await http.get(
        //create a file called secrets and add a const called "openWeatherAPIKey"
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherAPIKey'),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An Error occured while fetching the data';
      }
      setState(() {
        temp = data['list'][0]['main']['temp'];
      });
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
      body: temp == 0
          ? const CircularProgressIndicator()
          : SingleChildScrollView(
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
                                    "$temp °K",
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Icon(
                                    Icons.cloud,
                                    size: 64,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Rain",
                                    style: TextStyle(
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
                      "Weather Forcast",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // const SizedBox(height: 2),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          HourlyForcastitem(
                            time: "9:00am",
                            value: "301.17",
                            icon: Icons.cloud,
                          ),
                          HourlyForcastitem(
                            time: "8:00am",
                            value: "301.17",
                            icon: Icons.cloud,
                          ),
                          HourlyForcastitem(
                            time: "9:00pm",
                            value: "301.17",
                            icon: Icons.cloud,
                          ),
                          HourlyForcastitem(
                            time: "11:00pm",
                            value: "301.17",
                            icon: Icons.cloud,
                          ),
                          HourlyForcastitem(
                            time: "2:00pm",
                            value: "88.17",
                            icon: Icons.sunny,
                          ),
                        ],
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AddtionalInfoItem(
                          icon: Icons.water_drop,
                          label: "Humidity",
                          value: "91",
                        ),
                        AddtionalInfoItem(
                          icon: Icons.air,
                          label: "Wind Speed",
                          value: "7.67",
                        ),
                        AddtionalInfoItem(
                          icon: Icons.beach_access,
                          label: "Pressure",
                          value: "1006",
                        ),
                      ],
                    ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Card(
                    //       elevation: 0,
                    //       child: Container(
                    //         width: 115,
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: const Column(
                    //           children: [
                    //             Icon(
                    //               Icons.water_drop,
                    //               size: 30,
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Text(
                    //               "Humidity",
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //             Text(
                    //               "94",
                    //               style: TextStyle(
                    //                 fontSize: 24,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     //wind speed
                    //     Card(
                    //       elevation: 0,
                    //       child: Container(
                    //         width: 115,
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: const Column(
                    //           children: [
                    //             Icon(
                    //               Icons.wind_power,
                    //               size: 30,
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Text(
                    //               "Wind Speed",
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //             Text(
                    //               "7.67",
                    //               style: TextStyle(
                    //                 fontSize: 24,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     Card(
                    //       elevation: 0,
                    //       child: Container(
                    //         width: 115,
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: const Column(
                    //           children: [
                    //             Icon(
                    //               Icons.umbrella,
                    //               size: 30,
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Text(
                    //               "Pressure",
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //             Text(
                    //               "1006",
                    //               style: TextStyle(
                    //                 fontSize: 24,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

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
                  ],
                ),
              ),
            ),
    );
    // return const ;
  }
}
