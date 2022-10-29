import 'package:flutter/material.dart';
import 'package:restaurantfinal/models/m_reviewrestaurantt.dart';
import 'package:restaurantfinal/services/serv_review.dart';

class ReviewProvider with ChangeNotifier {
  late final ReviewService _service;
  List<RestaurantReview> reviews = [];
  bool isPostLoading = false;
  bool isDataLoading = true;

  bool isError = false;
  String errorMessage = '';

  ReviewProvider({required ReviewService service}) {
    _service = service;
  }

  void setDataLoading(bool status) {
    isDataLoading = status;
    notifyListeners();
  }

  void setPostLoading(bool status) {
    isPostLoading = status;
    notifyListeners();
  }

  void setErrorDataStatus(status) {
    isError = status;
    notifyListeners();
  }

  setInitData(List<RestaurantReview> data) {
    setDataLoading(true);
    reviews = data;
    setDataLoading(false);
  }

  void addReview(BuildContext context, String restaurantId, String name,
      String review) async {
    setPostLoading(true);
    List<RestaurantReview> newReviews =
        await _service.addReview(restaurantId, name, review);

    String message = '';
    Color notificationColor = Colors.green;
    if (reviews.length < newReviews.length) {
      reviews = newReviews;
      message = 'Sukses Menambahkan Review';
    } else {
      message = 'Gagal Menambahkan Review\nSilahkan Coba Lagi!';
      notificationColor = Colors.red;
    }

    var snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      content: Text(message),
      backgroundColor: notificationColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setPostLoading(false);
  }
}
