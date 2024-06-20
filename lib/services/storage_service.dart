import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import '../models/weather_data.dart';
import '../models/forecast_data.dart';

class StorageService {
  static const String _cityKey = 'city';
  static const String _weatherBox = 'weatherBox';
  static const String _forecastBox = 'forecastBox';

  Future<void> saveCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cityKey, city);
  }

  Future<String?> getCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_cityKey);
  }

  Future<void> saveWeatherData(WeatherData weatherData) async {
    var box = await Hive.openBox<WeatherData>(_weatherBox);
    await box.put('weatherData', weatherData);
  }

  Future<WeatherData?> getWeatherData() async {
    var box = await Hive.openBox<WeatherData>(_weatherBox);
    return box.get('weatherData');
  }

  Future<void> saveForecastData(List<ForecastData> forecastData) async {
    var box = await Hive.openBox<ForecastData>(_forecastBox);
    await box.putAll({for (var f in forecastData) f.date: f});
  }

  Future<List<ForecastData>> getForecastData() async {
    var box = await Hive.openBox<ForecastData>(_forecastBox);
    return box.values.toList();
  }
}
