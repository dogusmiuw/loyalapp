import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalappco/views/login_page.dart';

class IndexPage extends StatelessWidget {
  IndexPage({super.key});

  bool isLogged = FirebaseAuth.instance.currentUser != null;

  @override
  Widget build(BuildContext context) {
    if (!isLogged) {
      return Material(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 175,
            ),
            Image.asset('assets/img/loyalapp_logo.png'),
            Text(
              // * heading
              'Welcome to LoyalApp!',
              style:
                  GoogleFonts.rubik(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                // * paragraph
                'We are so excited to see you here!\nCome on, join us!',
                style: GoogleFonts.rubik(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 160,
            ),
            Padding(
              // ! BUTTON
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5025F4),
                    minimumSize: const Size.fromHeight(50)),
                child: Text('Get Started',
                    style: GoogleFonts.rubik(
                        fontSize: 20, fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      );
    } else {
      return Text('giris yaptin ya knk dont.', textDirection: TextDirection.ltr,);
    }
  }
}
