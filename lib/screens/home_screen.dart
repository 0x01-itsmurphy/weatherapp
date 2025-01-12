import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/forecast_list.dart';
import '../widgets/weather_card.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _fetchInitialWeather();
  }

  void _fetchInitialWeather() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeather('Bhopal');
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF263A57),
      appBar: _buildAppBar(weatherProvider),
      body: SafeArea(
        child: _buildBody(weatherProvider),
      ),
    );
  }

  // Method for building the AppBar
  AppBar _buildAppBar(WeatherProvider weatherProvider) {
    return AppBar(
      backgroundColor: const Color(0xFF1D2837),
      title: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => const SearchScreen()));
        },
        child: Row(
          children: [
            Text(
              weatherProvider.weather?.city ?? 'Unknown',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.location_on,
              size: 24,
              color: Colors.blue,
            ),
          ],
        ),
      ),
      actions: [
        _buildUnitSwitch(weatherProvider),
      ],
    );
  }

  // Method to build the unit switch in the AppBar
  Widget _buildUnitSwitch(WeatherProvider weatherProvider) {
    return Row(
      children: [
        const Text(
          'F',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Switch(
            value: weatherProvider.unit == 'metric',
            onChanged: (_) => weatherProvider.switchUnit(),
            activeTrackColor: Colors.lightBlueAccent,
            activeColor: Colors.blueAccent,
          ),
        ),
        const Text(
          'C',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  // Method to build the body content
  Widget _buildBody(WeatherProvider weatherProvider) {
    if (weatherProvider.weather == null || weatherProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (weatherProvider.errorMessage != null) {
      return _buildErrorScreen(weatherProvider);
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          WeatherCard(weather: weatherProvider.weather!),
          ForecastList(forecast: weatherProvider.weather!.forecast),
        ],
      ),
    );
  }

  // Method to build the error screen
  Widget _buildErrorScreen(WeatherProvider weatherProvider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weatherProvider.errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              weatherProvider.fetchWeather('Bhopal');
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
