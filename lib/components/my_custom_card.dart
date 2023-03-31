// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomCard extends StatelessWidget {
  const MyCustomCard(
      {super.key,
      required this.title,
      required this.imgPath,
      required this.description,
      required this.location,
      required this.date,
      required this.numOfPeople});

  final String title;
  final String imgPath;
  final String description;
  final String location;
  final DateTime date;
  final int numOfPeople;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Column(
        children: [
          Container(
            // ! CARD IMAGE
            height: 220,
            margin: EdgeInsets.symmetric(horizontal: 12),
            // padding: EdgeInsets.only(bottom: 20),
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              image: DecorationImage(
                image: AssetImage(imgPath),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
          // ! CARD CONTENT
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurple, width: 2),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // ! CARD TITLE
                Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.rubik(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    // ! NUM OF PEOPLE
                    Text(
                      numOfPeople.toString(),
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
                    const Icon(Icons.location_pin),
                    Text(
                      location,
                      style: GoogleFonts.rubik(fontSize: 17),
                    ),
                    const Spacer(),
                    const Icon(Icons.calendar_today),
                    // ! DATE
                    Text(
                      "${date.day}/${date.month}",
                      style: GoogleFonts.rubik(fontSize: 17),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // ! CARD DESC
                Text(
                  description,
                  style: GoogleFonts.rubik(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
