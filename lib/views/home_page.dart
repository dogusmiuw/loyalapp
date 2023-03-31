import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalappco/components/my_custom_card.dart';
import 'package:loyalappco/views/event_page.dart';
import 'package:loyalappco/views/profile_page.dart';
import 'package:loyalappco/service/auth.dart';
import 'package:loyalappco/views/login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  bool isLogged = FirebaseAuth.instance.currentUser != null;

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
                      'Welcome, back',
                      style: GoogleFonts.rubik(
                          fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    // ! PROFILE HUB START
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('assets/img/avatar.jpg'),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.person),
                                      Text(
                                        'Doğukan Çelik',
                                        style: GoogleFonts.rubik(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color:
                                            Color.fromARGB(255, 255, 234, 49),
                                      ),
                                      Text(
                                        'NFTs:',
                                        style: GoogleFonts.rubik(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '1',
                                        style: GoogleFonts.rubik(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
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
                        // * paragraph
                        'See what happened when you are not here!',
                        style: TextStyle(fontSize: 19),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // ! CARDS START
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EventPage()),
                        );
                      },
                      child: MyCustomCard(
                        title: 'English Speaking Club',
                        imgPath: 'assets/img/cafe.jpg',
                        description:
                            'Improve your English for free! Meet new people and drink some coffee!',
                        location: 'Hangout Cafe',
                        date: DateTime.utc(2023, 6, 20),
                        numOfPeople: 15,
                      ),
                    ),
                    MyCustomCard(
                      title: 'Beach Game',
                      imgPath: 'assets/img/beach.jpg',
                      description:
                          "Just chillin', playing some volleyball and drinking a lot of cocktails!",
                      location: 'Konyaalti Beach',
                      date: DateTime.utc(2023, 3, 31),
                      numOfPeople: 35,
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
    WidgetsBinding.instance /*?*/ .addPostFrameCallback((_) {
      // do something
      print("Build Completed");
    });
  }
}

class _NavbarState extends State<_Navbar> {
  int _selectedIndex = 0;

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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomePage()),
            // );
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
