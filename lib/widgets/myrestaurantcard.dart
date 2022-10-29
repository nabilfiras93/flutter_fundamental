import 'package:flutter/material.dart';
import 'package:restaurantfinal/config/colors.dart';
import 'package:restaurantfinal/config/const_values.dart';
import 'package:restaurantfinal/models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTapCallback;

  const RestaurantCard(
      {required this.restaurant, required this.onTapCallback, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _ratingCard(double rating) {
      return Container(
        width: 50,
        decoration: const BoxDecoration(
            color: backgroundTextImageColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              bottomRight: Radius.circular(8),
            )),
        padding: const EdgeInsets.only(right: 4, bottom: 10, top: 3),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          const Icon(Icons.star, color: ratingIconColor, size: 14),
          const SizedBox(width: 4),
          Text(rating.toString(),
              style: Theme.of(context).textTheme.overline?.copyWith(
                    color: textWhiteColor,
                  )),
        ]),
      );
    }

    _cityCard(String city) {
      return Container(
        width: 219,
        decoration: const BoxDecoration(
            color: backgroundTextImageColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(4),
              bottomLeft: Radius.circular(8),
            )),
        padding: const EdgeInsets.only(left: 4, bottom: 10, top: 3),
        child: Row(children: [
          const Icon(Icons.place, color: placeIconColor, size: 13),
          const SizedBox(width: 4),
          Text(city,
              style: Theme.of(context).textTheme.overline?.copyWith(
                    color: textWhiteColor,
                  )),
        ]),
      );
    }

    _nameCard(String name) {
      return Container(
          height: 44,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: backgroundTextImageColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          alignment: Alignment.centerLeft,
          child: Text(name,
              overflow: TextOverflow.clip,
              maxLines: 1,
              style: Theme.of(context).textTheme.overline?.copyWith(
                    color: textWhiteColor,
                    fontWeight: FontWeight.w600,
                  )));
    }

    return GestureDetector(
      onTap: onTapCallback,
      child: Stack(
        children: [
          Hero(
              tag: restaurant.pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                    mediumResolutionPictureUrl + restaurant.pictureId,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              )),
          Align(
              alignment: Alignment.bottomLeft,
              child: _ratingCard(restaurant.rating)),
          Align(
              alignment: Alignment.bottomRight,
              child: _cityCard(restaurant.city)),
          Align(
              alignment: Alignment.topCenter, child: _nameCard(restaurant.name))
        ],
      ),
    );
  }
}
