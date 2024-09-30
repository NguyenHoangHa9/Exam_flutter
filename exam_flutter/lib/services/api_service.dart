import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

class ApiService {
  Future<List<Map<String, String>>> getAllPlaces() async {
    final String response = await rootBundle.rootBundle.loadString('assets/places.json');
    final List<dynamic> data = json.decode(response);
    return data.map((place) {
      return {
        'name': place['name'] as String,
        'imageUrl': place['imageUrl'] as String,
      };
    }).toList();
  }
}
