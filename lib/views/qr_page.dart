import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalappco/views/profile_page.dart';
import 'package:loyalappco/service/auth.dart';
import 'package:loyalappco/views/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_page.dart';

class QRPage extends StatelessWidget {
  QRPage({super.key});

  bool isLogged = FirebaseAuth.instance.currentUser != null;
  // bool isLogged = true;

  @override
  Widget build(BuildContext context) {
    if (isLogged) {
      return Scaffold(
        bottomNavigationBar: _Navbar(),
        body: Material(
          color: Colors.white,
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 30), // ! MOST TOP SPACE
                    Text(
                      // * heading
                      'Attend Event',
                      style: GoogleFonts.rubik(
                          fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // ! PROFILE HUB START
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 100,
                                backgroundImage:
                                    AssetImage('assets/img/avatar.jpg'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Doğukan Çelik',
                                    style: GoogleFonts.rubik(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 255, 234, 49),
                                    size: 30,
                                  ),
                                  Text(
                                    'NFTs:',
                                    style: GoogleFonts.rubik(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '20',
                                    style: GoogleFonts.rubik(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ), // ! PROFILE HUB END
                    Image.asset('assets/img/qr.png'),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () async {
                          final Uri _url = Uri.parse('https://loyalapp.xyz/nft.html');
                          if (!await launchUrl(_url)) {
                            throw Exception('Could not launch $_url');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(side: BorderSide.none),
                            backgroundColor: const Color(0xFF5025F4),
                            minimumSize: const Size.fromHeight(50)),
                        child: const Text('Attend and Claim NFTs',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    const SizedBox(height: 20), // ! MOST BOTTOM SPACE
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Text(
        'giris yapilmadi',
        textDirection: TextDirection.ltr,
      );
    }
  }
}

class _Navbar extends StatefulWidget {
  const _Navbar({super.key});

  @override
  State<_Navbar> createState() => _NavbarState();

  @override
  void initState() {
    // super.initState();
    WidgetsBinding.instance /*?*/ .addPostFrameCallback((_) {
      // do something
      print("Build Completed");
    });
  }
}

class _NavbarState extends State<_Navbar> {
  int _selectedIndex = 0;
  final ScrollController _homeController = ScrollController();

  bool isLogged = FirebaseAuth.instance.currentUser != null;

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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            break;
          case 1:
            // TODO: NAVIGATE PROFILE
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
            break;
          case 2:
            // TODO: SIGN OUT
            setState(() {
              isLogged = false;
            });
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
