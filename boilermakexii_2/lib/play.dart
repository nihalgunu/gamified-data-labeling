import 'dart:ui';
import 'package:boilermakexii_2/classification_ai.dart';
import 'package:boilermakexii_2/segmentation.dart';
import 'package:flutter/material.dart';
import 'package:boilermakexii_2/const.dart';
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
            child: Column(
              children: [
                // Top row of two cards.
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: FrostedCard(
                          title: cardTitles[0],
                          onTap: () => _navigateToDetailPage(context, cardTitles[0]),
                        ),
                      ),
                      Expanded(
                        child: FrostedCard(
                          title: cardTitles[1],
                          onTap: () => _navigateToDetailPage(context, cardTitles[1]),
                        ),
                      ),
                    ],
                  ),
                ),
                // Bottom row of two cards.
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: FrostedCard(
                          title: cardTitles[2],
                          onTap: () => _navigateToDetailPage(context, cardTitles[2]),
                        ),
                      ),
                      Expanded(
                        child: FrostedCard(
                          title: cardTitles[3],
                          onTap: () => _navigateToDetailPage(context, cardTitles[3]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
    return Padding(
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
                  // Frosted glass background.
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
    );
  }
}
