import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantfinal/pages/myfavoriterestaurant_.dart';
import 'package:restaurantfinal/pages/mysetting_.dart';
import 'package:restaurantfinal/provider/prov_restaurant.dart';
import 'package:restaurantfinal/widgets/myplatformwidget.dart';
import 'package:restaurantfinal/widgets/myrestaurantcard.dart';

class RestaurantPage extends StatelessWidget {
  static const routeName = '/restaurant';
  const RestaurantPage({Key? key}) : super(key: key);

  Widget _listBuilder() {
    return Consumer<RestaurantProvider>(builder: (context, provider, _) {
      if (provider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else {
        if (provider.isError) {
          return Center(
              child: Text(provider.errorMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: Colors.black38)));
        } else {
          return GridView.count(
            crossAxisCount: 1,
            children: List.generate(
              provider.restaurants.length,
              (index) => Padding(
                padding: const EdgeInsets.all(10),
                child: RestaurantCard(
                  restaurant: provider.restaurants[index],
                  onTapCallback: () async {
                    FocusScope.of(context).unfocus();
                    Provider.of<RestaurantProvider>(context, listen: false)
                        .onTapRestaurant(
                      context,
                      index,
                    );
                  },
                ),
              ),
            ),
          );
        }
      }
    });
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 6, right: 6, top: 3),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Search Restaurant",
                          hintStyle: Theme.of(context).textTheme.bodyText2,
                        ),
                        onChanged: (text) {
                          Provider.of<RestaurantProvider>(context,
                                  listen: false)
                              .searchRestaurant(text);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RestaurantFavoritePage.routeName);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 24,
                            ),
                            Text(
                              "Favourite",
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  ?.copyWith(color: Colors.red),
                            )
                          ],
                        )),
                    const SizedBox(width: 16),
                    GestureDetector(
                        onTap: () async {
                          Navigator.pushNamed(context, SettingPage.routeName);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.settings,
                              color: Colors.black,
                              size: 24,
                            ),
                            Text(
                              "Setting",
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  ?.copyWith(color: Colors.black),
                            )
                          ],
                        )),
                  ],
                )),
            const SizedBox(height: 4),
            Expanded(child: _listBuilder())
          ],
        ));
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Restaurant App",
        style: Theme.of(context)
            .textTheme
            .subtitle1
            ?.copyWith(color: Colors.white),
      )),
      body: _buildContent(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Restaurant App",
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Colors.white),
        ),
        transitionBetweenRoutes: false,
      ),
      child: _buildContent(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
