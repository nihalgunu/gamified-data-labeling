import 'dart:typed_data';
import 'dart:ui';

import 'package:boilermakexii_2/mongo.dart';
import 'package:bounding_box_annotation/bounding_box_annotation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'; // For caching.
import 'package:boilermakexii_2/const.dart';
import 'package:http/http.dart' as http;

class SegmentationPage extends StatefulWidget {
  const SegmentationPage({super.key, required this.title});
  final String title;

  @override
  State<SegmentationPage> createState() => _SegmentationPageState();
}

class _SegmentationPageState extends State<SegmentationPage> {
  String prompt = "Describe the following image";
  final PageController _pageController = PageController();

  // Store the processed image URLs.
  List<String> newImageUrls = [];
  // We'll initialize our annotation controllers after computing the image URLs.
  late List<AnnotationController> annotationControllers;
  int currentPage = 0;
  final List<String> suggestions = ["Dog", "Cat", "Car", "Tree", "Building"];

  @override
  void initState() {
    super.initState();

    // Process the segmentation URLs once (assumes segmentation is defined in mongo.dart).
    newImageUrls = segmentation.map((url) {
      final RegExp regExp = RegExp(r'/d/([^/]+)/');
      final match = regExp.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        final fileId = match.group(1);
        return "https://drive.google.com/uc?export=view&id=$fileId";
      } else {
        return url;
      }
    }).toList();

    annotationControllers = List.generate(newImageUrls.length, (_) => AnnotationController());
  }

  /// Loads image bytes using DefaultCacheManager to take advantage of caching.
  Future<Uint8List> loadNetworkImageBytes(String imageUrl) async {
    final file = await DefaultCacheManager().getSingleFile(imageUrl);
    return file.readAsBytes();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      prompt,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: newImageUrls.length,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return FutureBuilder<Uint8List>(
                            future: loadNetworkImageBytes(newImageUrls[index]),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(color: darkBlue),
                                );
                              } else if (snapshot.hasError || !snapshot.hasData) {
                                return const Center(
                                    child: Icon(Icons.error, color: Colors.red));
                              } else {
                                return Stack(
                                  children: [
                                    Center(
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        margin: EdgeInsets.symmetric(
                                          vertical: currentPage == index ? 5 : 20,
                                        ),
                                        height: size.height * 0.75,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.white, width: 3),
                                          borderRadius: BorderRadius.circular(22),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: BoundingBoxAnnotation(
                                            controller: annotationControllers[index],
                                            imageBytes: snapshot.data!,
                                            imageWidth: size.width,
                                            imageHeight: size.height * 0.743,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 50,
                                      left: 20,
                                      right: 20,
                                      child: Container(
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
                                        width: size.width,
                                        height: size.height * 0.05,
                                        child: GestureDetector(
                                          child: Center(
                                            child: Text(
                                              "Save",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          onTap: () {
                                            _pageController.nextPage(
                                              duration: const Duration(milliseconds: 800),
                                              curve: Curves.easeInCubic,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // Back arrow button positioned at the top left.
              Positioned(
                top: 5,
                left: 16,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
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
