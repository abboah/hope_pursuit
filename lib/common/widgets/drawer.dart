import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final bool isLoggedIn;

  const CustomDrawer({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 2.5,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Container(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: isLoggedIn
                      ? IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.person_rounded))
                      : TextButton(
                          onPressed: () {},
                          child: const Text('Login'),
                        ),
                )),
          ),
          ListTile(
            leading: TextButton(
              onPressed: () {
                // Handle Products button tap
              },
              child: const Text('Products'),
            ),
            trailing: const Icon(Icons.archive),
          ),
          ListTile(
            leading: TextButton(
              onPressed: () {
                // Handle Settings button tap
              },
              child: const Text('Orders'),
            ),
            trailing: const Icon(CupertinoIcons.purchased),
          ),
          ListTile(
            leading: TextButton(
              onPressed: () {
                // Handle About button tap
              },
              child: const Text('Wishlist'),
            ),
            trailing: const Icon(CupertinoIcons.heart),
          ),
        ],
      ),
    );
  }
}
