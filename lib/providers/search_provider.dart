import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  List<String> cities = [];
  List<String> filteredCities = [];
  String? lastSearchedCity;

  SearchProvider() {
    _loadCities();
    _loadLastSearchedCity();
  }

  Future<void> _loadCities() async {
    try {
      final String response =
          await rootBundle.loadString('assets/cities-name-list.json');
      final List<dynamic> data = json.decode(response);
      cities = data.cast<String>();
      filteredCities = cities;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading cities: $e');
    }
  }

  Future<void> _loadLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    lastSearchedCity = prefs.getString('lastSearchedCity');
    notifyListeners();
  }

  Future<void> saveLastSearchedCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSearchedCity', city);
    lastSearchedCity = city;
    searchController.clear();
    notifyListeners();
  }

  void filterCities(String query) {
    if (query.isEmpty) {
      filteredCities = cities;
    } else {
      filteredCities = cities
          .where((city) => city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
