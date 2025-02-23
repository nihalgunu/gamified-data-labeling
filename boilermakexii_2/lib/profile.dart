import 'dart:math';

import 'package:boilermakexii_2/const.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final String userName;
  final String profileImageUrl;

  const UserProfile({
    super.key,
    required this.userName,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    int score = 45;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Start from the top
            end: Alignment.bottomCenter, // End at the bottom
            colors: [
              // pink1,  // Light pink at the top
              pink2,  // Slightly darker pink
              cyan3,  // Soft cyan transition
              // cyan2,
              // cyan1,  // Darker cyan
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profileImageUrl),
                    backgroundColor: Colors.white,
                  ),
                ),
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: size.height * 0.025,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
                Text(
                  "Bronze",
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "13th in Region",
                  style: TextStyle(
                    fontSize: size.height * 0.017,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                  child: Text(
                    "\$32.35",
                    style: TextStyle(
                      fontSize: size.height * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "Current Trophies: $score",
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                      child: SizedBox(
                        width: size.width/3,
                        height: size.height * 0.05,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: darkBlue,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          onPressed: () {

                          },
                          child: Text(
                            "Cash Out",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                      child: SizedBox(
                        width: size.width/3,
                        height: size.height * 0.05,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: darkBlue,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          onPressed: () {

                          },
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ProfileInfoCard(line1: "Processing...", line2: "0", arrow: 0, date: "3/23/25", increased_amt: 0.00),
                        ProfileInfoCard(line1: "Completed", line2: "3 Incorrect", arrow: -1, date: "3/22/25", increased_amt: 0.00),
                        ProfileInfoCard(line1: "Completed", line2: "All Correct", arrow: 1, date: "3/22/25", increased_amt: 1.3),
                        ProfileInfoCard(line1: "Completed", line2: "All Correct", arrow: 1, date: "3/21/25", increased_amt: 1.6),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final String line1;
  final String line2;
  final int arrow;
  final String date;
  final double increased_amt;

  const ProfileInfoCard({
    super.key,
    required this.line1,
    required this.line2,
    required this.arrow,
    required this.date,
    required this.increased_amt,
  });

  @override
  Widget build(BuildContext context) {
    double angle = 0;
    IconData icons = Icons.horizontal_rule_sharp;
    if (arrow < 0) {
      icons = Icons.arrow_forward_ios_sharp;
      angle = pi * 90 / 180;
    } else if (arrow > 0) {
      icons = Icons.arrow_forward_ios_sharp;
      angle = pi * -90 / 180;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: cyan2.withOpacity(0.3),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Transform.rotate(
                    angle: angle,
                    child: Icon(
                      icons,
                      size: 50,
                      color: darkBlue,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(date, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      Text(line1, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      Visibility(visible: arrow != 0, child: Text(line2, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300))),
                    ],
                  ),
                ],
              ),
              Text("+\$${increased_amt.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
