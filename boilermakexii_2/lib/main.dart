import 'package:boilermakexii_2/const.dart';
import 'package:boilermakexii_2/create_account.dart';
import 'package:boilermakexii_2/login.dart';
import 'package:boilermakexii_2/mongo.dart';
import 'package:boilermakexii_2/play.dart';
import 'package:boilermakexii_2/profile.dart';
import 'package:boilermakexii_2/segmentation.dart';
import 'package:boilermakexii_2/settings.dart';
import 'package:boilermakexii_2/classification.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';

Future<void> main() async {
  // mongo_tests();
  await fetchGroupedImages();
  print(segmentation);
  print(classification);
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
        textTheme: GoogleFonts.mandaliTextTheme().copyWith(
          bodyLarge: GoogleFonts.mandali(color: Colors.white),
          bodyMedium: GoogleFonts.mandali(color: Colors.white),
          bodySmall: GoogleFonts.mandali(color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
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
    FrostedCardsFullScreenPage(),
    // SegmentationPage(),
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
      bottomNavigationBar: DotNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        dotIndicatorColor: Colors.transparent,
        enablePaddingAnimation: true,
        items: [
          DotNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30,),
            selectedColor: Colors.white,
            unselectedColor: darkBlue,
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.play_arrow_outlined,size: 30,),
            selectedColor: Colors.white,
            unselectedColor: darkBlue,
          ),

          DotNavigationBarItem(
            icon: Icon(Icons.person_outlined,size: 30,),
            selectedColor: Colors.white,
            unselectedColor: darkBlue,
          ),

          DotNavigationBarItem(
            icon: Icon(Icons.settings_outlined, size: 30,),
            selectedColor: Colors.white,
            unselectedColor: darkBlue,
          ),
        ],
        // splashColor: kAccentBlue,
        marginR: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        paddingR: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      ),
    );
  }
}
