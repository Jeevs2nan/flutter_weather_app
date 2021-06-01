import 'package:flutter/material.dart';
import 'package:jeevanandhan_bestinet_test/screens/current_loc_screen.dart';
import 'package:jeevanandhan_bestinet_test/screens/favourite_screen.dart';
import 'package:jeevanandhan_bestinet_test/screens/weather_screen.dart';
import 'package:jeevanandhan_bestinet_test/util/network_connection.dart';
import 'package:provider/provider.dart';

import 'api/carosel_service.dart';
import 'api/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: MultiProvider(providers: [
       ChangeNotifierProvider(create: (_) => Services()),
       ChangeNotifierProvider(create: (_) => NetworkConnection()),
       ChangeNotifierProvider(create: (_) => CarouselService()),

     ],
       child: MyHomePage(),
     ),);

        /*title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),*/
        //home: MyHomePage(),

        /*home: ChangeNotifierProvider<Services>(
        builder: (context) => Services(),
        child: MyHomePage(),),
        );*/
    /*Provider<Services>(
          create: (context) => Services(),
          child: MyHomePage(),
        ));*/
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  PageController _pageController = PageController();

  List<Widget> _widgetOptions = <Widget>[
  FavoriteScreen(),
    WeatherScreen(),
    CurrentLocation()

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  void _onPageChanged(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: PageView(
        controller: _pageController,
        children: _widgetOptions,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlueAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_queue),
            label: 'Forecast',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Current Location',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
