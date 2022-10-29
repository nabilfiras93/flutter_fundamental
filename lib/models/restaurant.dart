import 'dart:convert';

class Restaurant{
  late final String id;
  late final String name;
  late final String description;
  late final String pictureId;
  late final String city;
  late final double rating;

  Restaurant(
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  );

  Restaurant.fromJson(Map<String, dynamic> restaurants){
    id = restaurants['id'];
    name = restaurants['name'];
    description = restaurants['description'];
    pictureId = restaurants['pictureId'];
    city = restaurants['city'];
    rating = double.parse(restaurants['rating'].toString());
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name' : name,
    'description' : description,
    'pictureId': pictureId,
    'city' : city,
    'rating': rating.toDouble(),
  };

  static List<Restaurant> parseRestaurants(String? json){
    if(json == null){
      return [];
    }

    var parsedJson = jsonDecode(json);
    return parsedJson['restaurants'].map<Restaurant>(
      (json) => Restaurant.fromJson(json)
    ).toList();
  }
}