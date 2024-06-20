import 'package:hive/hive.dart';

part 'forecast_data.g.dart';

@HiveType(typeId: 1)
class ForecastData extends HiveObject {
  @HiveField(0)
  final String date;

  @HiveField(1)
  final double temperature;

  @HiveField(2)
  final String description;

  ForecastData({
    required this.date,
    required this.temperature,
    required this.description,
  });
}
