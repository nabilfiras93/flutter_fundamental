import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurantfinal/config/colors.dart';
import 'package:restaurantfinal/pages/myrestaurant_.dart';
import 'package:restaurantfinal/widgets/myplatformwidget.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splashscreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () =>
            Navigator.pushReplacementNamed(context, RestaurantPage.routeName));
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 240,
              height: 2,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              "Restaurant App",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: textWhiteColor),
            ),
            const SizedBox(height: 10),
            Container(
              width: 240,
              height: 2,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(body: _buildContent(context));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(child: _buildContent(context));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
