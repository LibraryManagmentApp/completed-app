import 'package:flutter/material.dart';
import '../models/category.dart';
import '../widget/card_scroll_view.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRadio = cardAspectRatio * 1.2;

class _CategoryPageState extends State<CategoryPage> {
  var currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController _pageController =
    PageController(initialPage: images.length - 1);

    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });
    return Stack(
      children: [
        CardScrollView(currentPage),
        Positioned.fill(
            child: PageView.builder(
                itemCount: images.length,
                controller: _pageController,
                reverse: true,
                itemBuilder: (context,index){
                  return Container();
                }))
      ],
    );
  }
}