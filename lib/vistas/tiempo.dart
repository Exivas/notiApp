import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherView extends StatefulWidget {
  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  String _weather = '';
  String keyapi='9d91a896366243a09c82027915d68bd';

  void _fetchWeather() async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Santo Domingo&appid='+keyapi));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _weather = '${data['weather'][0]['description']}, Temp: ${data['main']['temp']}';
      });
    } else {
      setState(() {
        _weather = 'No pudimos conectar con el api';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in DR'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(_weather),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: Text('Refresh Weather'),
            ),
          ],
        ),
      ),
    );
  }
}
