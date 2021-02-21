import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nearme/core/datasource/locations.datasource.dart';
import 'package:nearme/core/features/list_page/list_page.dart';
import 'package:nearme/core/features/list_page/list_page.model.dart';
import 'package:nearme/core/repositories/locations.repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppeState createState() => _MyAppeState();
}

class _MyAppeState extends State<MyApp> {
  ILocationsDataSource locationsDataSource;
  ILocationsRepository locationsRepository;

  @override
  void initState() {
    locationsDataSource = LocationsDataSource();
    locationsRepository = LocationsRepository(
      locationsDataSource,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ListPageModel(locationsRepository),
        ),
        Provider(
          create: (_) => locationsDataSource,
        ),
        Provider(
          create: (_) => locationsRepository,
        ),
      ],
      child: MaterialApp(
        title: 'LatLong Sort',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ListPage(),
      ),
    );
  }
}
