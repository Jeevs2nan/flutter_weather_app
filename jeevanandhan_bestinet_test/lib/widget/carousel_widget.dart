import 'package:flutter/material.dart';
import 'package:jeevanandhan_bestinet_test/api/carosel_service.dart';
import 'package:jeevanandhan_bestinet_test/model/carousel_model.dart';
import 'package:provider/provider.dart';

class CarouselWidget extends StatelessWidget {

  String data = "";

  CarouselWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    final _carouselService = Provider.of<CarouselService>(context);
    CarouselDo _carouselDo = _carouselService.getResponseJson();

    return Center(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
              0.3,
              1
            ],
            colors: [
              Colors.lightBlueAccent,
              Colors.lightBlue,
            ]),
      ),
      child: Column(
        children: [
          Text(data, style: TextStyle(color: Colors.brown, fontSize: 30)),
        ],
      ),
    ));
  }
}
