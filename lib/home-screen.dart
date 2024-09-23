// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/model.dart';

class WeatherHome extends StatelessWidget {
  const WeatherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Weather App',
                style: TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () => print('Refresh'),
                  icon: const Icon(Icons.refresh_outlined))
            ],
          ),
          body: FutureBuilder(
            future: fetchApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                final model = snapshot.data!;
                return SingleChildScrollView(
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
                                borderRadius:
                                    BorderRadiusDirectional.circular(16)),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadiusDirectional.circular(15),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 5.5, sigmaY: 5.5),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text('${model.main?.temp}° F',
                                            style: const TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w700)),
                                      ),
                                      const SizedBox(height: 20),
                                      const Icon(Icons.cloud_rounded, size: 67),
                                      const SizedBox(height: 16),
                                      Center(
                                          child: Text(
                                              '${model.weather?[0].description}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 25)))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text("Today's weather",
                            style: TextStyle(
                                fontSize: 23.6, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                const Icon(CupertinoIcons.cloud_rain_fill,
                                    size: 33),
                                const SizedBox(height: 10),
                                const Text('Minimum',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 8),
                                Text(
                                  '${model.main?.tempMin}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  CupertinoIcons.cloud_bolt_rain_fill,
                                  size: 33,
                                ),
                                const SizedBox(height: 10),
                                const Text('Maximum',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 8),
                                Text(
                                  '${model.main?.tempMax}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  CupertinoIcons.cloud_fill,
                                  size: 33,
                                ),
                                const SizedBox(height: 10),
                                const Text('Predicted',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 8),
                                Text(
                                  '${model.main?.feelsLike}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text('Additional Information',
                            style: TextStyle(
                                fontSize: 23.6, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                const Icon(
                                  Icons.water_drop_rounded,
                                  size: 33,
                                ),
                                const SizedBox(height: 10),
                                const Text('Humidity',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 8),
                                Text(
                                  '${model.main?.humidity}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  Icons.air_rounded,
                                  size: 33,
                                ),
                                const SizedBox(height: 10),
                                const Text('Wind Speed',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 8),
                                Text(
                                  '${model.wind?.speed}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  Icons.beach_access_rounded,
                                  size: 33,
                                ),
                                const SizedBox(height: 10),
                                const Text('Pressure',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 8),
                                Text(
                                  '${model.main?.pressure}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                const Icon(
                                  Icons.water_rounded,
                                  size: 33,
                                ),
                                const SizedBox(height: 10),
                                const Text('Sea',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 8),
                                Text(
                                  '${model.main?.seaLevel}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  Icons.water_rounded,
                                  size: 33,
                                ),
                                const SizedBox(height: 10),
                                const Text('Ground',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 8),
                                Text(
                                  '${model.main?.grndLevel}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                const Icon(
                                  CupertinoIcons.sun_dust_fill,
                                  size: 33,
                                ),
                                const SizedBox(height: 10),
                                const Text('Sunrise',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 8),
                                Text(
                                  '${model.sys?.sunrise}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  Icons.visibility_rounded,
                                  size: 33,
                                ),
                                const SizedBox(height: 10),
                                const Text('Visibility',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 8),
                                Text(
                                  '${model.visibility}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  CupertinoIcons.sunset,
                                  size: 33,
                                ),
                                const SizedBox(height: 10),
                                const Text('Sunset',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 8),
                                Text(
                                  '${model.sys?.sunset}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: Text('Data not founded.'));
              }
            },
          )),
    );
  }

  Future<model?> fetchApi() async {
    final respone = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=9ac592d173972fe3590fb7fab1d7c812'),
    );
    if (respone.statusCode == 200) {
      final data = json.decode(respone.body);
      return model.fromJson(data);
    }
  }
}
