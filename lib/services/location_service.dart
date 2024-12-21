import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class LocationService {
  final StreamController<bool> _locationStreamController =
      StreamController<bool>.broadcast();

  Stream<bool> get locationStream => _locationStreamController.stream;

  LocationService() {
    _checkLocationContinuously();
  }

  void _checkLocationContinuously() async {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      _locationStreamController.add(isLocationEnabled);
    });
  }

  void dispose() {
    _locationStreamController.close();
  }
}
