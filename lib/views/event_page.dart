import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalappco/views/profile_page.dart';
import 'package:loyalappco/service/auth.dart';
import 'package:loyalappco/views/login_page.dart';
import 'package:loyalappco/views/qr_page.dart';

import 'home_page.dart';

class EventPage extends StatelessWidget {
  EventPage({super.key});

  bool isLogged = FirebaseAuth.instance.currentUser != null;
  // bool isLogged = true;
  // Future<void> _showMyDialog(String title, String desc) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {

  //     },
  //   );
  // }

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
                      'English Speaking Club',
                      style: GoogleFonts.rubik(
                          fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // ! EVENT IMAGE
                    Container(
                      height: 220,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      // padding: EdgeInsets.only(bottom: 20),
                      foregroundDecoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                        image: DecorationImage(
                          image: AssetImage('assets/img/cafe.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: null,
                    ),
                    // ! EVENT DETAILS START
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple, width: 2),
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(30)),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Icon(Icons.location_pin),
                              Text(
                                'Hangout Cafe / Antalya',
                                style: GoogleFonts.rubik(fontSize: 17),
                              ),
                              const Spacer(),
                              // ! NUM OF PEOPLE
                              Text(
                                '15',
                                style: GoogleFonts.rubik(
                                    fontSize: 20, color: Colors.grey[700]),
                              ),
                              Icon(Icons.people, color: Colors.grey[700]),
                            ],
                          ),
                          const SizedBox(height: 7),
                          // ! LOCATION
                          Row(
                            children: [
                              // ! DATE
                              const Icon(Icons.calendar_today),
                              Text(
                                '20/6',
                                style: GoogleFonts.rubik(fontSize: 17),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // ! CARD DESC
                          Text(
                            'Improve your English for free! Meet new people and drink some coffee!',
                            style: GoogleFonts.rubik(fontSize: 18),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                'Event Details:',
                                style: GoogleFonts.rubik(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              // Spacer()
                            ],
                          ),
                          SizedBox(height: 7),
                          Text(
                            'Event that will be held at Hangout. Language enthusiasts will have the opportunity to engage in various activities to improve their English skills, such as role-plays, debates, and vocabulary games. The event is expected to have a welcoming and friendly atmosphere, allowing participants to feel comfortable practicing their language skills. Attendees will have the chance to network, make new friends, and develop their language proficiency in an informal setting.',
                            style: GoogleFonts.rubik(fontSize: 18),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    // ! EVENT DETAILS END
                    SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QRPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(side: BorderSide.none),
                            backgroundColor: const Color(0xFF5025F4),
                            minimumSize: const Size.fromHeight(50)),
                        child: const Text('Attend',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    // MyCustomCard(
                    //   title: 'English Speaking Club',
                    //   imgPath: 'assets/img/cafe.jpg',
                    //   description:
                    //       'Improve your English for free! Meet new people and drink some coffee!',
                    //   location: 'Starbucks',
                    //   date: DateTime.utc(2023, 6, 20),
                    //   numOfPeople: 15,
                    // ),
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
