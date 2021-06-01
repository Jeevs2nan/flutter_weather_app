import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jeevanandhan_bestinet_test/api/carosel_service.dart';
import 'package:jeevanandhan_bestinet_test/model/carousel_model.dart';
import 'package:jeevanandhan_bestinet_test/util/Constant.dart';
import 'package:jeevanandhan_bestinet_test/util/cities_data.dart';
import 'package:jeevanandhan_bestinet_test/widget/carousel_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<String> favoriteCities = [];
  late CarouselService _carouselService;
  List<CarouselDo> carouselList = [];
  @override
  void initState() {
    super.initState();
    _loadFavoriteCities();
  }

  void _loadFavoriteCities() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    bool isFavoriteAvail =
        _preferences.containsKey(Constant.FAVORITE_PREFERENCE_KEY);

    if (!isFavoriteAvail) {
      favoriteCities.addAll(Cities.CITY_LIST.getRange(0, 4));
      _preferences.setString(Constant.FAVORITE_PREFERENCE_KEY,
          favoriteCities.join(",").toString());
    } else {
      String favStr =
          _preferences.getString(Constant.FAVORITE_PREFERENCE_KEY) ?? "";
      favoriteCities = favStr.split(",");
    }

  }

  void _addFavorite() {}

  @override
  Widget build(BuildContext context) {
    _carouselService = Provider.of<CarouselService>(context);

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              new Spacer(),
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: _addFavorite,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child:

            CarouselSlider.builder(
              itemCount: favoriteCities.length,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height/1.50,
                aspectRatio: 2.0,
                enlargeCenterPage: false,
                autoPlay: false,
              ),
              itemBuilder: (ctx, index, realIdx) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: CarouselWidget(data: favoriteCities.elementAt(index)),
                );
              },

            ),
          ),
        ],
      ),
    );
  }
}
