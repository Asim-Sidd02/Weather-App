import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/weather_data.dart';
import 'models/forecast_data.dart';
import 'services/api_service.dart';
import 'services/storage_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherData? weatherData;
  List<ForecastData>? forecastData;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    final storageService = StorageService();
    final city = await storageService.getCity() ?? 'San Francisco';
    await _fetchWeather(city);
  }

  Future<void> _fetchWeather(String city) async {
    try {
      final data = await ApiService().fetchWeather(city);
      final weather = WeatherData(
        city: data['name'],
        temperature: data['main']['temp'] - 273.15,
        description: data['weather'][0]['description'],
        sunrise: DateTime.fromMillisecondsSinceEpoch(data['sys']['sunrise'] * 1000),
        sunset: DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'] * 1000),
        humidity: data['main']['humidity'],
        precipitation: data['rain'] != null ? data['rain']['1h'] : 0.0,
        airQuality: 60,
      );
      setState(() {
        weatherData = weather;
      });
      await StorageService().saveWeatherData(weather);
      await StorageService().saveCity(city);
      await _fetchForecast(city);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _fetchForecast(String city) async {
    try {
      final data = await ApiService().fetchForecast(city);
      final Map<String, ForecastData> forecastMap = {};

      for (var item in data['list']) {
        final date = item['dt_txt'].toString().split(' ')[0]; // Extract date without time
        final forecast = ForecastData(
          date: date,
          temperature: item['main']['temp'] - 273.15,
          description: item['weather'][0]['description'],
        );

        // Only add the forecast if it's the first entry for that date
        if (!forecastMap.containsKey(date)) {
          forecastMap[date] = forecast;
        }
      }

      setState(() {
        forecastData = forecastMap.values.toList();
      });

      await StorageService().saveForecastData(forecastData!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _onSearchSubmitted(String city) {
    _fetchWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Enter city name',
                            hintStyle: const TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.white24,
                            filled: true,
                          ),
                          style: const TextStyle(color: Colors.white),
                          onSubmitted: _onSearchSubmitted,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          _onSearchSubmitted(_searchController.text);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    weatherData?.city ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Current Weather',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 24,
                    ),
                  ),
                  if (weatherData != null) ...[
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Image.network(
                            'http://openweathermap.org/img/wn/${getIconCodeFromDescription(weatherData!.description)}@2x.png',
                            height: 100,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '${weatherData!.temperature.toStringAsFixed(1)}°C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            weatherData!.description.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildWeatherInfo('Sunrise', DateFormat('hh:mm a').format(weatherData!.sunrise)),
                        _buildWeatherInfo('Sunset', DateFormat('hh:mm a').format(weatherData!.sunset)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildWeatherInfo('Air Quality', '${weatherData!.airQuality} Moderate'),
                        _buildWeatherInfo('Humidity', '${weatherData!.humidity}%'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildWeatherInfo('Precipitation', '${weatherData!.precipitation}%'),
                      ],
                    ),
                  ],
                  const SizedBox(height: 20),
                  const Text(
                    '5-Day Forecast',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 24,
                    ),
                  ),
                  forecastData != null
                      ? _buildForecastList()
                      : const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildForecastList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: forecastData!.length,
      itemBuilder: (context, index) {
        final forecast = forecastData![index];
        return ListTile(
          leading: Image.network(
            'http://openweathermap.org/img/wn/${getIconCodeFromDescription(forecast.description)}@2x.png',
            height: 50,
          ),
          title: Text(
            '${forecast.temperature.toStringAsFixed(1)}°C',
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            forecast.description,
            style: const TextStyle(color: Colors.white70),
          ),
          trailing: Text(
            DateFormat('EEE, MMM d').format(DateTime.parse(forecast.date)),
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  String getIconCodeFromDescription(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return '01d';
      case 'few clouds':
        return '02d';
      case 'scattered clouds':
        return '03d';
      case 'broken clouds':
        return '04d';
      case 'shower rain':
        return '09d';
      case 'rain':
        return '10d';
      case 'thunderstorm':
        return '11d';
      case 'snow':
        return '13d';
      case 'mist':
        return '50d';
      default:
        return '01d';
    }
  }
}
