// an appbar that shrinks into a drawer on a smaller screen
import 'package:flutter/material.dart';
import 'package:hope_pursuit/screens/home/home.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(85);
  final bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 5,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, Home.routeName);
            },
            child: Image.asset(
              'assets/images/hp.png',
              fit: BoxFit.cover,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('Products'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Settings'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('About'),
            ),
            _isLoggedIn
                ? IconButton(
                    onPressed: () {}, icon: const Icon(Icons.person_rounded))
                : TextButton(
                    onPressed: () {},
                    child: const Text('Login'),
                  )
          ],
        );
      } else {
        return AppBar(
          scrolledUnderElevation: 5,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, Home.routeName);
            },
            child: Image.asset(
              'assets/images/hp.png',
              fit: BoxFit.cover,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              // Open Drawer
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        );
      }
    });
  }
}
