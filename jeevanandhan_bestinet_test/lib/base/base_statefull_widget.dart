import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

abstract class _BaseState<T> extends State<StatefulWidget> {

   bool _connectionStatus = false;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
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
          setState(() => _connectionStatus = true);
        }
        break;
      default:
        print("Enters in _updateConnectionStatus default");
        setState(() => _connectionStatus = false);
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  bool get getInternetConnectionStatus => _connectionStatus;
   StatefulWidget? _statefulWidget;
   void set getStateclass(StatefulWidget _statefulWidget) {
     this._statefulWidget = _statefulWidget;
   }

}
