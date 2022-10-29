import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:restaurantfinal/models/m_detailrestaurant.dart';
import 'package:restaurantfinal/pages/mydetailrestaurant_.dart';
import 'package:restaurantfinal/provider/prov_favorite.dart';
import 'package:restaurantfinal/services/serv_restaurant.dart';
import 'package:restaurantfinal/widgets/myplatformwidget.dart';
import 'package:restaurantfinal/widgets/myrestaurantcard.dart';

class RestaurantFavoritePage extends StatelessWidget {
  static const routeName = '/favorite-restaurant-page';

  const RestaurantFavoritePage({Key? key}) : super(key: key);

  Widget _buildContent(BuildContext context) {
    return Consumer<FavoriteProvider>(builder: (context, provider, _) {
      if (provider.restaurants.isEmpty) {
        return Center(
            child: Text("Favourite Restaurant is Empty",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Colors.black38)));
      } else {
        return GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            provider.restaurants.length,
            (index) => Padding(
              padding: const EdgeInsets.all(3),
              child: RestaurantCard(
                restaurant: provider.restaurants[index],
                onTapCallback: () async {
                  FocusScope.of(context).unfocus();

                  DetailRestaurant restaurant =
                      await RestaurantService(client: http.Client())
                          .getRestaurant(provider.restaurants[index].id);

                  Navigator.pushNamed(context, DetailRestaurantPage.routeName,
                      arguments: restaurant);
                },
              ),
            ),
          ),
        );
      }
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Favourite Restaurant",
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Colors.white),
        )),
        body: _buildContent(context));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            "Favourite Restaurant",
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: Colors.white),
          ),
          transitionBetweenRoutes: false,
        ),
        child: _buildContent(context));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
