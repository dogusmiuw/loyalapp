import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalappco/components/my_custom_card.dart';
import 'package:loyalappco/service/auth.dart';
import 'package:loyalappco/views/login_page.dart';

import 'home_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

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
                      'Profile',
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
                                    '1',
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
                    // ! INFO TEXT
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        // * bio
                        'student, hates to live',
                        style: TextStyle(fontSize: 19),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // ! CARDS START
                    Padding(
                      padding: EdgeInsets.fromLTRB(18, 0, 0, 10),
                      child: Row(
                        children: [
                          Text(
                              // * bio
                              'Events',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                          Spacer()
                        ],
                      ),
                    ),
                    MyCustomCard(
                      title: 'English Speaking Club',
                      imgPath: 'assets/img/cafe.jpg',
                      description:
                          'Improve your English for free! Meet new people and drink some coffee!',
                      location: 'Hangout Cafe',
                      date: DateTime.utc(2023, 6, 20),
                      numOfPeople: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(18, 0, 0, 10),
                      child: Row(
                        children: [
                          Text(
                              // * bio
                              'NFT Badges',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                          Spacer()
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/img/nft.png',
                              width: 150,
                            ),
                            Text(
                              'First Event',
                              style: GoogleFonts.rubik(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30), // ! MOST BOTTOM SPACE
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // do something
      print("Build Completed");
    });
  }
}

class _NavbarState extends State<_Navbar> {
  int _selectedIndex = 1;
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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ProfilePage()),
            // );
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
