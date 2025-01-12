import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/search_provider.dart';
import '../providers/weather_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF263A57),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D2837),
        foregroundColor: Colors.white,
        title: const Text(
          'Search Cities',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<SearchProvider>(
        builder: (context, searchProvider, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchInput(
                  controller: searchProvider.searchController,
                  onChanged: searchProvider.filterCities,
                ),
                if (searchProvider.lastSearchedCity != null &&
                    searchProvider.searchController.text.isEmpty)
                  _buildLastSearchedCity(
                    lastSearchedCity: searchProvider.lastSearchedCity!,
                    onSelect: (selectedCity) async {
                      await weatherProvider.fetchWeather(selectedCity);
                      await searchProvider.saveLastSearchedCity(selectedCity);
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                  ),
                if (searchProvider.lastSearchedCity == null ||
                    searchProvider.searchController.text.isNotEmpty)
                  _buildCityList(
                    cities: searchProvider.filteredCities,
                    onCityTap: (selectedCity) async {
                      await weatherProvider.fetchWeather(selectedCity);
                      await searchProvider.saveLastSearchedCity(selectedCity);
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchInput({
    required TextEditingController controller,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          labelText: 'Search',
          labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildLastSearchedCity({
    required String lastSearchedCity,
    required Function(String) onSelect,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Last searched city',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          ActionChip(
            label: Text(
              lastSearchedCity,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF1D2837),
            onPressed: () => onSelect(lastSearchedCity),
          ),
        ],
      ),
    );
  }

  Widget _buildCityList({
    required List<String> cities,
    required Function(String) onCityTap,
  }) {
    return Expanded(
      child: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              cities[index],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            onTap: () => onCityTap(cities[index]),
          );
        },
      ),
    );
  }
}
