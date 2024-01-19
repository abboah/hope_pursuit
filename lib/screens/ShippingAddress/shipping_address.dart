import 'package:flutter/material.dart';
import 'package:hope_pursuit/common/widgets/appbar.dart';
import 'package:hope_pursuit/utils/app_colors.dart';
import 'package:hope_pursuit/utils/font_styles.dart';

class ShippingAddress extends StatelessWidget {
  static const String routeName = 'shippingAddress';
  const ShippingAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      appBar: const CustomAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildAddress(context),
      ],
    );
  }

  Widget _buildAddress(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _buildTitle(context, Icons.location_on_outlined, 'Shipping Address'),
          const SizedBox(height: 20.0),
          _buildAddressCard(context),
        ],
      ),
    );
  }

  Widget _buildTitle(
    BuildContext context,
    IconData icon,
    String title,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primaryLight,
        ),
        const SizedBox(width: 10.0),
        Text(
          title,
          style: FontStyles.montserratBold17().copyWith(fontSize: 19.0),
        )
      ],
    );
  }

  Widget _buildAddressCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Oleh Chabanov',
                style: FontStyles.montserratBold17().copyWith(fontSize: 14.0),
              ),
              const Icon(Icons.arrow_forward_ios_rounded)
            ],
          ),
          const SizedBox(height: 5.0),
          const Text('225 Highland Aven\nSpringfield, IL 62704, USA')
        ],
      ),
    );
  }
}
