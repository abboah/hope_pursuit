import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hope_pursuit/utils/app_colors.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: AppColors.blueBlack.withOpacity(1),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Hope Pursuit',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5.0),
          const Text(
            'Explore the Latest Trends in Fashion',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const FooterLink(
                title: 'Home',
              ),
              const FooterLink(title: 'Shop'),
              const FooterLink(title: 'About Us'),
              const FooterLink(title: 'Contact'),
              FooterLink(
                  title: 'Privacy Policy',
                  onTap: () {
                    // Implement navigation to the privacy policy page
                  }),
            ],
          ),
          const SizedBox(height: 10.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialMediaIcon(
                  icon: FontAwesomeIcons.facebook,
                  url: 'https://www.facebook.com/hopepursuit'),
              SocialMediaIcon(
                  icon: FontAwesomeIcons.xTwitter,
                  url: 'https://twitter.com/hopepursuit'),
              SocialMediaIcon(
                  icon: FontAwesomeIcons.instagram,
                  url: 'https://www.instagram.com/hopepursuit/'),
            ],
          ),
          const SizedBox(height: 10.0),
          const Text(
            '© 2022 Hope Pursuit. All rights reserved.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class FooterLink extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const FooterLink({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SocialMediaIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const SocialMediaIcon({super.key, required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement opening the social media link
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          size: 30.0,
          color: Colors.blue,
        ),
      ),
    );
  }
}
