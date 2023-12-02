import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forcast_item.dart';

class NoApiWeatherScreen extends StatefulWidget {
  const NoApiWeatherScreen({super.key});

  @override
  State<NoApiWeatherScreen> createState() => _NoApiWeatherScreenState();
}

class _NoApiWeatherScreenState extends State<NoApiWeatherScreen> {
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "230 °K",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            Icon(
                              Icons.cloud,
                              size: 64,
                            ),
                            SizedBox(height: 16),
                            Text(
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
              const Text(
                "Weather Forcast",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
    // return const ;
  }
}
