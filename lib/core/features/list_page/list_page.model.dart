import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nearme/core/constants/constants.dart';
import 'package:nearme/core/models/location.model.dart';
import 'package:nearme/core/repositories/locations.repository.dart';

class ListPageModel extends ChangeNotifier {
  ListPageModel(this.locationsRepository);

  final ILocationsRepository locationsRepository;

  final List<Location> _cachedLocations = [];
  List<Location> locations = [];

  Future<List<Location>> getLocations() async {
    if (_cachedLocations.isEmpty) {
      _cachedLocations.addAll(
        await locationsRepository.getLocations(),
      );
    }

    locations = _cachedLocations;
    notifyListeners();
    return _cachedLocations;
  }

  List<Location> sortLocation() {
    _cachedLocations.sort((a, b) => getDistanceBetweenPointsNew(
          latitude1: myLocation["lat"],
          longitude1: myLocation["long"],
          latitude2: a.lat,
          longitude2: a.long,
        ).compareTo(getDistanceBetweenPointsNew(
          latitude1: myLocation["lat"],
          longitude1: myLocation["long"],
          latitude2: b.lat,
          longitude2: b.long,
        )));

    locations = _cachedLocations;
    notifyListeners();
    return _cachedLocations;
  }

  getDistanceBetweenPointsNew({
    latitude1,
    longitude1,
    latitude2,
    longitude2,
    String unit = 'Mi',
  }) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(latitude2 - latitude1); // deg2rad below
    var dLon = deg2rad(longitude2 - longitude1);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad(latitude1)) *
            cos(deg2rad(latitude2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  double deg2rad(deg) {
    return deg * (pi / 180);
  }
}
