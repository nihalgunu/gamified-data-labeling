import 'package:flutter/material.dart';
import 'package:boilermakexii_2/const.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'main.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  // Controllers for Page 1
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordVerifyController = TextEditingController();

  // Interests for Page 3
  final List<String> interests = [
    "Sports",
    "Music",
    "Travel",
    "Technology",
    "Art",
    "Cooking",
    "Reading",
    "Writing",
    "Photography",
    "Gaming",
    "Fitness",
    "Dancing",
    "Hiking",
    "Fishing",
    "Gardening",
    "Crafting",
    "Drawing",
    "Painting",
    "Yoga",
    "Meditation",
    "Cycling",
    "Running",
    "Swimming",
    "Martial Arts",
    "Bird Watching",
    "Astronomy",
    "History",
    "Science",
    "Mathematics",
    "Baking",
    "DIY",
    "Woodworking",
    "Model Building",
    "Knitting",
    "Sewing",
    "Fashion",
    "Cosplay",
    "Blogging",
    "Podcasting",
    "Volunteering",
    "Animal Welfare",
    "Environmentalism",
    "Investing",
    "Entrepreneurship",
    "Finance",
    "Politics",
    "Philosophy",
    "Languages",
    "Learning",
    "Geography",
    "Cultural Studies",
    "Food",
    "Wine Tasting",
    "Craft Beer",
    "Coffee",
    "Tea",
    "Gadgets",
    "Automotive",
    "Motorcycling",
    "Skating",
    "Snowboarding",
    "Surfing",
    "Scuba Diving",
    "Camping",
    "RV Living",
    "Theater",
    "Movies",
    "Stand-up Comedy",
    "Board Games",
    "Card Games",
    "Puzzle Solving",
    "Travel Blogging"
  ];

  final Set<String> selectedInterests = {};

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // Let the scaffold resize when the keyboard appears (default behavior)
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [pink2, cyan3],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // PageView with the 4 pages
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  children: [
                    // Page 1: User Info Form
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        left: size.width * 0.08,
                        right: size.width * 0.08,
                        bottom: MediaQuery.of(context).viewInsets.bottom + size.height * 0.02,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: size.height * 0.8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Title with divider
                            Column(
                              children: [
                                Text(
                                  "Create Account",
                                  style: TextStyle(
                                    fontSize: size.height * 0.035,
                                    fontWeight: FontWeight.bold,
                                    color: darkBlue,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                                  child: Divider(
                                    color: darkBlue,
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                            // Text fields
                            Column(
                              children: [
                                TextField(
                                  controller: _fullNameController,
                                  style: TextStyle(color: darkBlue),
                                  cursorColor: darkBlue,
                                  decoration: InputDecoration(
                                    hintText: "Full Name",
                                    hintStyle: TextStyle(color: darkBlue.withOpacity(0.6)),
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.9),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.02),
                                TextField(
                                  controller: _ageController,
                                  style: TextStyle(color: darkBlue),
                                  cursorColor: darkBlue,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Age",
                                    hintStyle: TextStyle(color: darkBlue.withOpacity(0.6)),
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.9),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.02),
                                TextField(
                                  controller: _emailController,
                                  style: TextStyle(color: darkBlue),
                                  cursorColor: darkBlue,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: darkBlue.withOpacity(0.6)),
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.9),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.02),
                                TextField(
                                  controller: _passwordController,
                                  style: TextStyle(color: darkBlue),
                                  cursorColor: darkBlue,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: darkBlue.withOpacity(0.6)),
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.9),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.02),
                                TextField(
                                  controller: _passwordVerifyController,
                                  style: TextStyle(color: darkBlue),
                                  cursorColor: darkBlue,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Verify Password",
                                    hintStyle: TextStyle(color: darkBlue.withOpacity(0.6)),
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.9),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Page 2: Diploma/Credentials Upload (Optional)
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        left: size.width * 0.08,
                        right: size.width * 0.08,
                        bottom: MediaQuery.of(context).viewInsets.bottom + size.height * 0.02,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: size.height * 0.8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Title with divider
                            Column(
                              children: [
                                Text(
                                  "Upload Diploma (Optional)",
                                  style: TextStyle(
                                    fontSize: size.height * 0.035,
                                    fontWeight: FontWeight.bold,
                                    color: darkBlue,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                                  child: Divider(
                                    color: darkBlue,
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: darkBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ).copyWith(
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                    splashFactory: NoSplash.splashFactory,
                                  ),
                                  onPressed: () {
                                    // TODO: Implement upload functionality
                                  },
                                  child: Text(
                                    "Upload Photo",
                                    style: TextStyle(
                                      fontSize: size.height * 0.022,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                Text(
                                  "Skip if you don't have any credentials to upload.",
                                  style: TextStyle(
                                    fontSize: size.height * 0.018,
                                    color: darkBlue,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Page 3: Interests Selection (Aligned at top)
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        left: size.width * 0.08,
                        right: size.width * 0.08,
                        bottom: MediaQuery.of(context).viewInsets.bottom + size.height * 0.02,
                        top: size.height * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title with divider
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select Your Interests",
                                style: TextStyle(
                                  fontSize: size.height * 0.035,
                                  fontWeight: FontWeight.bold,
                                  color: darkBlue,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                                child: Divider(
                                  color: darkBlue,
                                  thickness: 2,
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: interests.map((interest) {
                              bool isSelected = selectedInterests.contains(interest);
                              return ChoiceChip(
                                label: Text(
                                  interest,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : darkBlue,
                                  ),
                                ),
                                selected: isSelected,
                                selectedColor: darkBlue,
                                backgroundColor: Colors.white,
                                shape: StadiumBorder(side: BorderSide(color: darkBlue)),
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedInterests.add(interest);
                                    } else {
                                      selectedInterests.remove(interest);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    // Page 4: Get Started (Logo at top)
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        left: size.width * 0.08,
                        right: size.width * 0.08,
                        bottom: MediaQuery.of(context).viewInsets.bottom + size.height * 0.02,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: size.height * 0.8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Logo at top
                            CircleAvatar(
                              radius: 90,
                              backgroundColor: Colors.transparent,
                              child: SvgPicture.asset('assets/AI_Generated_Logo_2025-02-23_6c928111-f8d5-491b-990e-fc4ecd9387de (2).svg',
                                color: darkBlue,
                                width: 200,
                                height: 200,
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            // Title with divider
                            Column(
                              children: [
                                Text(
                                  "Get Started!",
                                  style: TextStyle(
                                    fontSize: size.height * 0.035,
                                    fontWeight: FontWeight.bold,
                                    color: darkBlue,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                                  child: Divider(
                                    color: darkBlue,
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "We are excited to have you join our community. Let's get started on your journey!",
                              style: TextStyle(
                                fontSize: size.height * 0.022,
                                color: darkBlue,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Navigation row with page indicator and arrow buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: size.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back arrow button or placeholder
                    currentPage > 0
                        ? IconButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: Icon(Icons.arrow_back, color: darkBlue, size: size.height * 0.04),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    )
                        : SizedBox(width: size.height * 0.04),
                    // Page indicator
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: 4,
                      effect: WormEffect(
                        activeDotColor: darkBlue,
                        dotColor: Colors.white,
                        dotHeight: 12,
                        dotWidth: 12,
                      ),
                    ),
                    // Forward arrow button
                    IconButton(
                      onPressed: () {
                        // On Page 1, validate if passwords match
                        if (currentPage == 0) {
                          if (_passwordController.text != _passwordVerifyController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Passwords do not match")),
                            );
                            return;
                          }
                        }
                        if (currentPage < 3) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          // Finish account creation process and navigate with a fade+zoom animation
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 700),
                              pageBuilder: (context, animation, secondaryAnimation) =>
                              const MainScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: ScaleTransition(
                                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
                                    child: child,
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                      icon: Icon(Icons.arrow_forward, color: darkBlue, size: size.height * 0.04),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
