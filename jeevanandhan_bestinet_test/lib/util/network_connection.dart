

import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class NetworkConnection extends ChangeNotifier {
  NetworkConnection() {
    initiateListener();
  }

  bool _connectionStatus = false;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;


  void initiateListener() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        String resultStr = result.toString();
        if (resultStr != null && resultStr.length > 0) {
          print("Enters in _updateConnectionStatus case");
          _connectionStatus = true;
        }
        break;
      default:
        _connectionStatus = false;
        break;
    }

    notifyListeners();
  }



  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  bool get getInternetConnectionStatus => _connectionStatus;




}