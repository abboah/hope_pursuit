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
            onTap: () {},
            leading: Text('Products'),
            trailing: const Icon(Icons.archive),
          ),
          ListTile(
            onTap: () {},
            leading: Text('Orders'),
            trailing: const Icon(CupertinoIcons.purchased),
          ),
          ListTile(
            onTap: () {},
            leading: Text('Wishlist'),
            trailing: const Icon(CupertinoIcons.heart),
          ),
        ],
      ),
    );
  }
}
