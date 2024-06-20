import 'package:hive/hive.dart';

part 'weather_data.g.dart';

@HiveType(typeId: 0)
class WeatherData extends HiveObject {
  @HiveField(0)
  final String city;

  @HiveField(1)
  final double temperature;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime sunrise;

  @HiveField(4)
  final DateTime sunset;

  @HiveField(5)
  final int humidity;

  @HiveField(6)
  final double precipitation;

  @HiveField(7)
  final int airQuality;

  WeatherData({
    required this.city,
    required this.temperature,
    required this.description,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
    required this.precipitation,
    required this.airQuality,
  });
}
