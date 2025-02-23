import 'dart:math';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'const.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
];

final List<Widget> imageSliders =
    imgList.map((item) {
      return Container(
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Image.network(
            item,
            fit: BoxFit.cover,
            width: 300,
            height: 300,
          ),
        ),
      );
    }).toList();

List<Widget> infocards = [
  InfoCard(
    imageUrl: 'https://picsum.photos/200/500',
    line1: "Lane McCormick",
    line2: "10",
    line3: "101",
  ),
  InfoCard(
    imageUrl: 'https://picsum.photos/900/500',
    line1: "Bob Dale",
    line2: "12",
    line3: "45",
  ),
  InfoCard(
    imageUrl: 'https://picsum.photos/100/800',
    line1: "Sarah Thompson",
    line2: "25",
    line3: "78",
  ),
  InfoCard(
    imageUrl: 'https://picsum.photos/600/700',
    line1: "Ethan Carter",
    line2: "31",
    line3: "92",
  ),
  InfoCard(
    imageUrl: 'https://picsum.photos/300/500',
    line1: "Olivia Bennett",
    line2: "19",
    line3: "37",
  ),
  InfoCard(
    imageUrl: 'https://picsum.photos/200/400',
    line1: "James Nolan",
    line2: "28",
    line3: "55",
  ),
  InfoCard(
    imageUrl: 'https://picsum.photos/200/300',
    line1: "Sophia Reed",
    line2: "22",
    line3: "81",
  ),
  InfoCard(
    imageUrl: 'https://picsum.photos/400/800',
    line1: "Daniel Foster",
    line2: "29",
    line3: "60",
  ),
  InfoCard(
    imageUrl: 'https://picsum.photos/300/200',
    line1: "Ava Collins",
    line2: "18",
    line3: "42",
  ),
  InfoCard(
    imageUrl: 'https://picsum.photos/100/600',
    line1: "Liam Harrison",
    line2: "34",
    line3: "99",
  ),
  InfoCard(
    imageUrl: 'https://picsum.photos/300/500',
    line1: "Chloe Martin",
    line2: "27",
    line3: "74",
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double trophiesFontsize = size.width * 0.05;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/background.jpg",
            ), // Change to your image path
            fit: BoxFit.fitHeight,
            alignment: Alignment(0, 0.2),
          ),
        ),
        child: SafeArea(
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
              Positioned(
                top: size.height * 0.04, // Adjusted to maintain spacing
                left: 0,
                right: 0,
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.35,
                  child: CustomPaint(
                    painter: MountainPainter(
                      mountainColor: Colors.white,
                      backgroundColor: kBackgroundColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: -100,
                child: CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    padEnds: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.easeInOutCirc,
                    enlargeFactor: 1,
                    autoPlay: true,
                    viewportFraction: 0.5,
                    scrollDirection: Axis.vertical,
                  ),
                  items: infocards,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String imageUrl;
  final String line1;
  final String line2;
  final String line3;

  const InfoCard({
    super.key,
    required this.imageUrl,
    required this.line1,
    required this.line2,
    required this.line3,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Card(
        color: cyan1.withOpacity(0.3),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 30),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    line1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Recent Cash Out: \$$line2",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    "Current Trophies: $line3",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MountainPainter extends CustomPainter {
  final Color mountainColor;
  final Color backgroundColor;

  MountainPainter({required this.mountainColor, required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint =
        Paint()
          ..color = mountainColor
          ..style = PaintingStyle.fill;
    Offset leftCircleCenter = Offset(size.width * 0.4, size.height * 1.05);
    Offset rightCircleCenter = Offset(size.width * 0.8, size.height * 1.22);

    const double circleRadius = 10.0;
    canvas.drawCircle(leftCircleCenter, circleRadius, circlePaint);
    canvas.drawCircle(rightCircleCenter, circleRadius, circlePaint);

    _drawIndicator(canvas, leftCircleCenter, circleRadius, "You", "45");
    _drawIndicator(canvas, rightCircleCenter, circleRadius, "John Monroe", "90");
  }

  void _drawIndicator(
    Canvas canvas,
    Offset circleCenter,
    double radius,
    String name,
    String score,
  ) {
    Offset circleTop = Offset(circleCenter.dx, circleCenter.dy - radius);
    double lineLength = 20.0;
    Offset lineEnd = Offset(circleTop.dx, circleTop.dy - lineLength);

    final Paint linePaint =
        Paint()
          ..color = mountainColor
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke;

    canvas.drawLine(circleTop, lineEnd, linePaint);

    TextSpan textSpan = TextSpan(
      style: TextStyle(color: mountainColor, fontSize: 12),
      text: "$name\n$score",
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
