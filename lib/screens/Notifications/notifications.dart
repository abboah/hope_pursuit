import 'package:flutter/material.dart';
import 'package:hope_pursuit/common/widgets/appbar.dart';
import 'package:hope_pursuit/screens/notifications/widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = 'notifications';
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: buildNotificationList(context),
    );
  }

  // PreferredSize _buildAppBar(BuildContext context) {
  //   return PreferredSize(
  //     preferredSize: const Size(double.infinity, 100),
  //     child: CustomAppBar(
  //         isHome: false,
  //         fixedHeight: 100,
  //         enableSearchField: false,
  //         leadingIcon: plateform.Platform.isIOS
  //             ? Icons.arrow_back_ios
  //             : Icons.arrow_back,
  //         leadingOnTap: () {
  //           Navigator.pop(context);
  //         },
  //         title: 'Notifications'),
  //   );
  // }

  Widget buildNotificationList(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) {
        return NotificationItem(
            seen: false,
            notificationImage:
                "https://fdn.gsmarena.com/imgroot/news/19/12/top-phones-of-2019/-727/gsmarena_001.jpg",
            notificationMessage: "New Product in Women Categories added",
            isImageAvailable: true,
            onPressed: () async {},
            notificationTimestamp: DateTime.now());
      },
    );
  }
}
