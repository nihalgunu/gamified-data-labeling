import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:boilermakexii_2/const.dart';
import 'package:boilermakexii_2/mongo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClassificationAI extends StatefulWidget {
  const ClassificationAI({super.key, required this.title});
  final String title;

  @override
  State<ClassificationAI> createState() => _ClassificationAIState();
}

class _ClassificationAIState extends State<ClassificationAI> {
  String prompt = "Describe the following image";
  final PageController _pageController = PageController();
  List<String> newImageUrls = [];
  int currentPage = 0;
  final List<String> suggestions = [
    "Deer",
    "Elephant",
    "Bike",
    "Player",
    "Sportsman",
    "Bee",
    "Flower",
    "Apple",
    "Dog",
    "Cat",
    "Bottle",
    "Building",
    "Backpack"
  ];

  // List of offsets for the MountainPainter.
  List<Offset> offsets = [
    Offset(-7, 160),
    Offset(30, 135),
    Offset(50, 120),
    Offset(70, 104),
  ];

  // Countdown timer variables.
  int _remainingSeconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Process the classification URLs once.
    newImageUrls = classification.map((url) {
      final RegExp regExp = RegExp(r'/d/([^/]+)/');
      final match = regExp.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        final fileId = match.group(1);
        return "https://drive.google.com/uc?export=view&id=$fileId";
      } else {
        return url;
      }
    }).toList();

    // Start countdown timer.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Loads an image's bytes using http.get (your original method).
  Future<Uint8List> loadNetworkImageBytes(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception("Failed to load image");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Determine the dynamic offsets for the mountain.
    // Use the current page for offset1 and, if available, currentPage-1 for offset2.
    Offset offset1 = offsets[currentPage % offsets.length];
    Offset offset2 = currentPage > 0 ? offsets[(currentPage - 1) % offsets.length] : offsets[0];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.fitHeight,
            alignment: Alignment(0, 0.2),
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Main content column.
              Column(
                children: [
                  // Top: Custom-painted mountain graph (with dynamic offsets) and countdown timer.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomPaint(
                          size: const Size(250, 250),
                          painter: MountainPainter(
                            circleOffset1: offset1,
                            circleOffset2: offset2,
                          ),
                        ),
                        const SizedBox(width: 16),
                        CountdownTimer(remainingSeconds: _remainingSeconds),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      prompt,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.height * 0.022,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  // Expanded PageView for images with stacked prompt and input.
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: newImageUrls.length,
                        physics: const PageScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Image container.
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: EdgeInsets.symmetric(
                                    vertical: currentPage == index ? 5 : 20,
                                  ),
                                  height: size.height * 0.5, // Reduced height.
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 3),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: newImageUrls[index],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(color: darkBlue),
                                      ),
                                      errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                                    ),
                                  ),
                                ),
                                // Positioned autocomplete text field at the bottom of the image container.
                                Positioned(
                                  bottom: 10,
                                  left: 20,
                                  right: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.cyan.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(22),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Autocomplete<String>(
                                      optionsBuilder: (TextEditingValue textEditingValue) {
                                        if (textEditingValue.text.isEmpty) {
                                          return const Iterable<String>.empty();
                                        } else {
                                          return suggestions.where(
                                                (word) => word.toLowerCase().contains(textEditingValue.text.toLowerCase()),
                                          );
                                        }
                                      },
                                      optionsViewBuilder: (context, onSelected, options) {
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(22),
                                              color: Colors.transparent,
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Wrap(
                                              spacing: 8.0,
                                              runSpacing: 4.0,
                                              children: options.map<Widget>((option) {
                                                return ActionChip(
                                                  label: Text(option.toString()),
                                                  surfaceTintColor: Colors.transparent,
                                                  onPressed: () {
                                                    onSelected(option.toString());
                                                  },
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        );
                                      },
                                      onSelected: (selectedString) {},
                                      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                                        return TextField(
                                          textAlign: TextAlign.left,
                                          controller: controller,
                                          focusNode: focusNode,
                                          onEditingComplete: () {
                                            FocusScope.of(context).unfocus();
                                            onEditingComplete();
                                            if (controller.text != '') {
                                              _pageController.nextPage(
                                                duration: const Duration(milliseconds: 800),
                                                curve: Curves.easeInOutCubic,
                                              );
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            hintText: 'Enter Classification',
                                            hintStyle: TextStyle(color: Colors.white),
                                            border: InputBorder.none,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // Back arrow button at the top left.
              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// CustomPainter that draws a "half mountain" graph along with two customizable circles.
class MountainPainter extends CustomPainter {
  final Offset circleOffset1;
  final Offset circleOffset2;
  MountainPainter({required this.circleOffset1, required this.circleOffset2});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint pathPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final Path path = Path();
    // Adjusted mountain-like path.
    path.moveTo(-100, size.height * 0.9);
    path.lineTo(size.width * 0.3, size.height * 0.4);
    path.lineTo(size.width * 0.6, size.height * 0.7);
    path.lineTo(size.width * 1.5, size.height * 0.2);
    canvas.drawPath(path, pathPaint);

    final Paint circlePaint = Paint()
      ..color = darkBlue
      ..style = PaintingStyle.fill;
    // Draw the two circles.
    canvas.drawCircle(circleOffset1, 8, circlePaint);
    canvas.drawCircle(circleOffset2, 8, circlePaint);

    // Draw text indicators above each circle.
    _drawIndicator(canvas, circleOffset1, "You");
    _drawIndicator(canvas, circleOffset2, "AI");
  }

  void _drawIndicator(Canvas canvas, Offset circleCenter, String label) {
    // Compute the top of the circle (using a fixed radius of 8).
    Offset circleTop = Offset(circleCenter.dx, circleCenter.dy - 8);
    double lineLength = 20.0;
    Offset lineEnd = Offset(circleTop.dx, circleTop.dy - lineLength);

    final Paint linePaint = Paint()
      ..color = darkBlue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(circleTop, lineEnd, linePaint);

    TextSpan textSpan = TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 16),
      text: label,
    );

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    Offset textOffset = Offset(
      lineEnd.dx + 5,
      lineEnd.dy - (textPainter.height / 2),
    );
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant MountainPainter oldDelegate) {
    return oldDelegate.circleOffset1 != circleOffset1 ||
        oldDelegate.circleOffset2 != circleOffset2;
  }
}

/// A simple countdown timer widget.
class CountdownTimer extends StatelessWidget {
  final int remainingSeconds;
  const CountdownTimer({Key? key, required this.remainingSeconds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.timer_outlined, color: Colors.white),
        const SizedBox(width: 10),
        Text(
          "${remainingSeconds}s",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
