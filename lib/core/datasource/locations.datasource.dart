import 'dart:convert';
import 'package:nearme/core/models/location.model.dart';
import 'package:flutter/services.dart';

abstract class ILocationsDataSource {
  Future<List<Location>> getLocations();
}

class LocationsDataSource implements ILocationsDataSource {
  @override
  Future<List<Location>> getLocations() async {
    try {
      String data = await rootBundle.loadString('assets/data/locations.json');
      final result = json.decode(data);
      return List<Location>.from(
        result.map(
          (i) => Location.fromJson(i),
        ),
      );
    } catch (e) {
      return [];
    }
  }
}
