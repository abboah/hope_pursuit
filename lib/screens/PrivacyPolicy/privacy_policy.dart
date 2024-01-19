import 'package:flutter/material.dart';
import 'package:hope_pursuit/common/Widgets/appbar.dart';
import 'package:hope_pursuit/utils/Constants/app_constants.dart';
import 'package:hope_pursuit/utils/font_styles.dart';

class PrivacyPolicy extends StatelessWidget {
  static const String routeName = 'privacypolicy';
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy and Policies',
              style: FontStyles.montserratBold17().copyWith(
                  fontSize: 18.0, decoration: TextDecoration.underline),
            ),
            const SizedBox(height: 10.0),
            Text(
              AppConstants.privacyPolicyTxt,
              style: FontStyles.montserratRegular14()
                  .copyWith(fontSize: 15.0, wordSpacing: 1.5, height: 1.5),
            ),
          ],
        ));
  }
}
