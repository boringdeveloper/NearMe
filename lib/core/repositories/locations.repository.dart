import 'package:nearme/core/datasource/locations.datasource.dart';
import 'package:nearme/core/models/location.model.dart';

abstract class ILocationsRepository {
  Future<List<Location>> getLocations();
}

class LocationsRepository implements ILocationsRepository {
  LocationsRepository(this.locationsDataSource);

  final ILocationsDataSource locationsDataSource;

  @override
  Future<List<Location>> getLocations() async {
    return locationsDataSource.getLocations();
  }
}
