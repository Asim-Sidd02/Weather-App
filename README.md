# Flutter Weather App

## _This Flutter application fetches and displays current weather and 5-day forecast for a selected city using a public API. It also stores the selected city and weather data locally for offline access._

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [File Structure](#file-structure)
- [ScreenShots](#screenshots)
- [Author](#author)
- [License](#license)

## Introduction

This Flutter app provides a user-friendly interface to view current weather details and a forecast for the next five days based on the selected city. It utilizes a public API to fetch real-time weather data and stores this information locally using Hive, ensuring data availability even when offline.

## Features

- Display current weather information including temperature, description, sunrise, sunset, humidity, and precipitation.
- Show a 5-day weather forecast with details like date, temperature, and description.
- Store selected city and fetched weather data locally for offline access.
- Simple and clean UI designed for ease of use.

## Prerequisites

Before running the application, ensure you have the following installed:

- Flutter SDK
- Dart SDK
- Android SDK / Xcode (depending on your target platform)
- IDE (e.g., VS Code, Android Studio) with Flutter and Dart plugins

## Installation

Clone the repository:

```sh
git clone https://github.com/Asim-Sidd02/Weather-App.git
cd Weather-App



```

Install the dependencies using flutter:

```sh
flutter pub get
```

## File Structure

The project directory structure is organized as follows:

- **lib/**: Contains Dart code for the Flutter application.
  - **main.dart**: Entry point of the application.
  - **weather_screen.dart**: UI code for displaying weather information.
- **models/**: Contains data model classes.
  - **weather_data.dart**: Model class for current weather data.
  - **forecast_data.dart**: Model class for forecast data.
- **services/**: Contains service classes.
  - **api_service.dart**: Handles API requests to fetch weather data.
  - **hive_setup.dart**: Sets up local storage using Hive for storing weather data.
  - **storage_service.dart**: Manages storing and retrieving data locally.
- **README.md**: Project overview and file structure details.
- **pubspec.yaml**: Flutter project configuration file with dependencies and other settings.

## Models

The **models/** directory contains data model classes used throughout the application:

- **weather_data.dart**: Defines the structure for storing current weather information.
- **forecast_data.dart**: Defines the structure for storing weather forecast information.

These models are used to parse JSON data received from the API and store it in Dart objects.

## Services

The **services/** directory contains service classes responsible for data handling and API interactions:

- **api_service.dart**: Implements methods to fetch weather data from a public API.
- **hive_setup.dart**: Sets up local storage using Hive, a lightweight and fast NoSQL database, to store weather data locally.
- **storage_service.dart**: Manages storing and retrieving weather data locally using Hive.

## Screens

The **lib/** directory contains screen files:

- **weather_screen.dart**: Implements the UI for displaying current weather details and the 5-day forecast. It interacts with the services to fetch and display data.

## Dependencies

This project relies on the following Flutter packages:

- **hive**: For local NoSQL database storage.
- **http**: For making HTTP requests to fetch data from the weather API.
- **intl**: For internationalization and date formatting.
- **shared_preferences**: For displaying SVG icons in the UI.
  
These dependencies are specified in the **pubspec.yaml** file.

## ScreenShots
<img src="https://github.com/Asim-Sidd02/Weather-App/blob/main/ss1.jpg" alt="Screenshot">
<img src="https://github.com/Asim-Sidd02/Weather-App/blob/main/ss2.jpg" alt="Screenshot">




## Author

- **Asim Siddiqui**
- **Contact Information**
  - Email: asimsiddiqui8181@gmail.com
  - LinkedIn: [Asim Siddiqui](https://www.linkedin.com/in/asim-siddiqui-a71731229/)
  - Portfolio: [Asim Sidd](https://asimsidd.vercel.app/)


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.


