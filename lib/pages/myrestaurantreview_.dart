import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantfinal/provider/prov_review.dart';
import 'package:restaurantfinal/widgets/myplatformwidget.dart';

class RestaurantReviewPage extends StatelessWidget {
  static const routeName = '/restaurant-review-page';

  final String restaurantId;
  final String restaurantName;

  RestaurantReviewPage(
      {Key? key, required this.restaurantId, required this.restaurantName})
      : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "Nama Lengkap"),
              ),
              const SizedBox(height: 2),
              TextFormField(
                controller: reviewController,
                decoration: const InputDecoration(
                  hintText: "Review",
                ),
              ),
              const SizedBox(height: 14),
              Consumer<ReviewProvider>(
                builder: (context, provider, _) {
                  if (provider.isPostLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return GestureDetector(
                      onTap: () {
                        provider.addReview(context, restaurantId,
                            nameController.text, reviewController.text);
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        height: 45,
                        alignment: Alignment.center,
                        child: Text(
                          "Kirim",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Review",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Expanded(
          child: Consumer<ReviewProvider>(builder: (context, provider, _) {
            if (provider.isDataLoading) {
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
                return ListView.builder(
                    padding: const EdgeInsets.only(top: 4),
                    itemCount: provider.reviews.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                          height: 90,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    provider.reviews[index].name,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    provider.reviews[index].date,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )
                                ],
                              ),
                              const SizedBox(height: 4),
                              Expanded(
                                child: Text(
                                  provider.reviews[index].review,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ],
                          ),
                        ));
              }
            }
          }),
        ),
      ],
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          restaurantName,
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
            restaurantName,
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
