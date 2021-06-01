import 'package:flutter/material.dart';

class NoInternetConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Icon(Icons.network_check),
          SizedBox(
            height: 20,
          ),
          Text('Check Internet Connection'),
        ],
      ),
    );
  }
}
