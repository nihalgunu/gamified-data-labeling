import 'dart:ui';
import 'package:boilermakexii_2/classification_ai.dart';
import 'package:boilermakexii_2/segmentation.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:boilermakexii_2/const.dart';
import 'package:flutter_svg/svg.dart';
import 'classification.dart';

class FrostedCardsFullScreenPage extends StatelessWidget {
  const FrostedCardsFullScreenPage({Key? key}) : super(key: key);

  final List<String> cardTitles = const [
    "Classification",
    "Segmentation",
    "Classification vs AI",
    "Segmentation vs AI",
  ];

  void _navigateToDetailPage(BuildContext context, String title) {
    Widget destination;
    if(title == "Classification vs AI") {
      destination = ClassificationAI(title: title);
    }
      else if (title.contains("Classification")) {
      destination = ClassificationPage(title: title);
    } else if (title.contains("Segmentation")) {
      destination = SegmentationPage(title: title);
    } else {
      destination = const Scaffold(
        body: Center(child: Text("Page not found")),
      );
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => destination,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    List<Widget> cards = [
      FrostedCard(
        title: cardTitles[0],
        onTap: () => _navigateToDetailPage(context, cardTitles[0]),
      ),
      FrostedCard(
        title: cardTitles[1],
        onTap: () => _navigateToDetailPage(context, cardTitles[1]),
      ),
      FrostedCard(
        title: cardTitles[2],
        onTap: () => _navigateToDetailPage(context, cardTitles[2]),
      ),
      FrostedCard(
        title: cardTitles[3],
        onTap: () => _navigateToDetailPage(context, cardTitles[3]),
      ),
    ];

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background image.
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: size.width * 0.1,
                    right: size.width * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset('assets/money-svgrepo-com.svg',
                              color: Colors.white,
                              width: 50,
                              height: 50,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              "\$32.35",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          'assets/AI_Generated_Logo_2025-02-23_6c928111-f8d5-491b-990e-fc4ecd9387de (2).svg',
                          width: 200,
                          height: 200,
                        ),
                        Column(
                          children: [
                            SvgPicture.asset('assets/trophy-svgrepo-com-2.svg',
                              color: Colors.white,
                              width: 50,
                              height: 50,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              "45",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.25,),
                        CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 3/3.2,
                            // padEnds: false,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                            autoPlayAnimationDuration: Duration(milliseconds: 600),
                            autoPlayCurve: Curves.easeInOutCirc,
                            enlargeFactor: 0.3,
                            autoPlay: true,
                            viewportFraction: 0.8,
                            // scrollDirection: Axis.horizontal,
                          ),
                          items: cards,
                        ),
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: FrostedCard(
                  //           title: cardTitles[0],
                  //           onTap: () => _navigateToDetailPage(context, cardTitles[0]),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: FrostedCard(
                  //           title: cardTitles[1],
                  //           onTap: () => _navigateToDetailPage(context, cardTitles[1]),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Expanded(
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: FrostedCard(
                  //           title: cardTitles[2],
                  //           onTap: () => _navigateToDetailPage(context, cardTitles[2]),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: FrostedCard(
                  //           title: cardTitles[3],
                  //           onTap: () => _navigateToDetailPage(context, cardTitles[3]),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FrostedCard extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const FrostedCard({Key? key, required this.title, this.onTap}) : super(key: key);

  /// Returns an icon based on the title.
  IconData get icon {
    if (title.contains("Classification")) {
      return Icons.class_;
    } else if (title.contains("Segmentation")) {
      return Icons.crop;
    }
    return Icons.info;
  }

  /// For titles with "vs AI", split the text into multiple lines.
  String get displayText {
    if (title == "Classification vs AI") {
      return "Classification\nvs.\nAI";
    } else if (title == "Segmentation vs AI") {
      return "Segmentation\nvs.\nAI";
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: onTap,
          child: Hero(
            tag: 'card_$title',
            child: Material(
              type: MaterialType.transparency,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: darkBlue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    // Centered content: icon on top, text below.
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            color: Colors.white,
                            size: 28,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            displayText,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
