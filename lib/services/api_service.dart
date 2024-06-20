import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = 'e3a33f2da96fd7539ee3717ba52b5749';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, dynamic>> fetchForecast(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}
