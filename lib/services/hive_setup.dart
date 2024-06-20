import 'package:hive_flutter/hive_flutter.dart';
import '../models/weather_data.dart';

import '../models/forecast_data.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WeatherDataAdapter());
  Hive.registerAdapter(ForecastDataAdapter());
}
