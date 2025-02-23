import 'package:boilermakexii_2/const.dart';
import 'package:boilermakexii_2/mongo.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:substring_highlight/substring_highlight.dart';

class ClassificationPage extends StatefulWidget {
  const ClassificationPage({super.key, required this.title});
  final String title;

  @override
  State<ClassificationPage> createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
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

  @override
  Widget build(BuildContext context) {
    // Process the classification URLs on every build (consider moving this to initState for performance)
    for (String url in classification) {
      final RegExp regExp = RegExp(r'/d/([^/]+)/');
      final match = regExp.firstMatch(url);

      if (match != null && match.groupCount >= 1) {
        final fileId = match.group(1);
        final newUrl = "https://drive.google.com/uc?export=view&id=$fileId";
        newImageUrls.add(newUrl);
      } else {
        newImageUrls.add(url);
      }
    }

    TextEditingController controller = TextEditingController();

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
              // Main content
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
                        physics: PageScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Center(
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin: EdgeInsets.symmetric(
                                    vertical: currentPage == index ? 5 : 20,
                                  ),
                                  height: size.height * 0.75,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: newImageUrls[index],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: darkBlue,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 50,
                                left: 20,
                                right: 20,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.cyan.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(22),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Autocomplete(
                                      optionsBuilder: (TextEditingValue textEditingValue) {
                                        if (textEditingValue.text.isEmpty) {
                                          return const Iterable<String>.empty();
                                        } else {
                                          return suggestions.where(
                                                (word) => word.toLowerCase().contains(
                                              textEditingValue.text.toLowerCase(),
                                            ),
                                          );
                                        }
                                      },
                                      optionsViewBuilder: (
                                          context,
                                          Function(String) onSelected,
                                          options,
                                          ) {
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(22),
                                              color: Colors.transparent,
                                            ),
                                            padding: EdgeInsets.all(8.0),
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
                                      fieldViewBuilder: (
                                          context,
                                          controller,
                                          focusNode,
                                          onEditingComplete,
                                          ) {
                                        return TextField(
                                          textAlign: TextAlign.left,
                                          controller: controller,
                                          focusNode: focusNode,
                                          onEditingComplete: () {
                                            FocusScope.of(context).unfocus(); // Dismiss the keyboard
                                            onEditingComplete(); // Call the provided callback
                                            if (controller.text != '') {
                                              _pageController.nextPage(
                                                duration: Duration(milliseconds: 800),
                                                curve: Curves.easeInOutCubic,
                                              );
                                            }
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Enter Classification',
                                            hintStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // Back arrow button at the top left.
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
