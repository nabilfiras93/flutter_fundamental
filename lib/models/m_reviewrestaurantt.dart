class RestaurantReview{
  late final String name;
  late final String review;
  late final String date;

  RestaurantReview({
    required this.name,
    required this.review,
    required this.date,
  });

  RestaurantReview.fromJson(Map<String, dynamic> json){
    name = json['name'];
    review = json['review'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'review': review,
    'date': date
  };
}