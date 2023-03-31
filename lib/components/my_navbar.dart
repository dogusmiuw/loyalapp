import 'package:flutter/material.dart';
import 'package:loyalappco/service/auth.dart';
import 'package:loyalappco/views/login_page.dart';

class _Navbar extends StatefulWidget {
  const _Navbar({super.key});

  @override
  State<_Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<_Navbar> {
  int _selectedIndex = 0;
  final ScrollController _homeController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Sign Out',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.deepPurple[800],
      onTap: (int index) async {
        switch (index) {
          case 0:
            // TODO: NAVIGATE HOME
            break;
          case 1:
            // TODO: NAVIGATE PROFILE
            break;
          case 2:
            // TODO: SIGN OUT
            print('cikistan once : ${Auth().currentUser?.email}');
            await Auth().signOut();
            print('cikistan sonra: ${Auth().currentUser?.email}');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
            break;
        }
        setState(
          () {
            _selectedIndex = index;
          },
        );
      },
    );
  }

  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Example Dialog'),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
      ),
    );
  }
}
