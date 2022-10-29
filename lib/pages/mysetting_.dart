import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantfinal/provider/prov_schedule.dart';
import 'package:restaurantfinal/widgets/myplatformwidget.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting-page';
  const SettingPage({Key? key}) : super(key: key);

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Material(
          child: ListTile(
            title: const Text('Restaurant'),
            subtitle: const Text(
                'Kamu akan menerima notifikasi saran restoran dari kami'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isScheduled,
                  onChanged: (value) async {
                    scheduled.setScheduledStatus(value);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Pengaturan",
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(color: Colors.white),
        )),
        body: _buildContent(context));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            "Pengaturan",
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
