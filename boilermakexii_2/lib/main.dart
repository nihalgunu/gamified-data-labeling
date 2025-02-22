import 'package:boilermakexii_2/const.dart';
import 'package:boilermakexii_2/profile.dart';
import 'package:boilermakexii_2/settings.dart';
import 'package:boilermakexii_2/start.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.amber,
        ),
        // scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.mandaliTextTheme().copyWith(
          bodyLarge: GoogleFonts.mandali(color: Colors.white),
          bodyMedium: GoogleFonts.mandali(color: Colors.white),
          bodySmall: GoogleFonts.mandali(color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    HomePage(),
    StartPage(),
    UserProfile(
      userName: "Prickle Peanuts",
      profileImageUrl: "https://picsum.photos/200",
    ),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      // bottomNavigationBar: Theme(
      //   data: Theme.of(context).copyWith(
      //     // canvasColor: cyan1.withOpacity(0.8),
      //     cardColor: Colors.transparent,
      //     shadowColor: Colors.transparent,
      //     primaryColor: Colors.transparent,
      //     scaffoldBackgroundColor: Colors.transparent,
      //     indicatorColor: Colors.transparent,
      //     canvasColor: Colors.transparent,
      //     splashColor: Colors.transparent,
      //     highlightColor: Colors.transparent,
      //   ),
      //   child: BottomNavigationBar(
      //     items: <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ""),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.circle_outlined),
      //         label: "",
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person_outlined),
      //         label: "",
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.settings_outlined),
      //         label: "",
      //       ),
      //     ],
      //     currentIndex: _selectedIndex,
      //     selectedItemColor: kLightBlue,
      //     selectedFontSize: 0,
      //     unselectedFontSize: 0,
      //     enableFeedback: true,
      //     showSelectedLabels: false,
      //     showUnselectedLabels: false,
      //     unselectedItemColor: kAccentBlue,
      //     backgroundColor: Colors.transparent,
      //     iconSize: 30,
      //     onTap: _onItemTapped,
      //   ),
      // ),
      bottomNavigationBar: DotNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        dotIndicatorColor: Colors.transparent,
        enablePaddingAnimation: true,
        items: [
          DotNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            selectedColor: Colors.white,
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.circle_outlined),
            selectedColor: Colors.white,
          ),

          DotNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            selectedColor: Colors.white,
          ),

          DotNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            selectedColor: Colors.white,
          ),
        ],
        // splashColor: kAccentBlue,
        marginR: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        paddingR: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      ),
    );
  }
}
