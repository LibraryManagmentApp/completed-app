import 'package:flutter/material.dart';
import '../models/book.dart';
import '../constant.dart';
import '../provider/cart.dart';

class Top extends StatefulWidget {
  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> with SingleTickerProviderStateMixin {
  PageController _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  _bookSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext c, Widget widget) {
        double value = 1;
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 500.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
              tag: book[index].imageUrl,
              child: Container(
                decoration: BoxDecoration(borderRadius:BorderRadius.circular(16),),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 25),
                child: Image(
                  image: AssetImage('assets/images/ph$index.jpg'),
                  width: 300,
                  height: 450,
                  fit: BoxFit.fill,
                ),
              )),
          Positioned(
              bottom: 0,
              left: 30,
              child: RawMaterialButton(
                  padding: EdgeInsets.all(15),
                  shape: CircleBorder(),
                  elevation:3,
                  //fillColor: Colors.black,
                  fillColor:firstColor,
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    print('add to cart');
                    cart();
                  })
          ),
          Positioned(
              bottom: 0,
              right: 30,
              child: RawMaterialButton(
                  padding: EdgeInsets.all(15),
                  shape: CircleBorder(),
                  elevation: 3,
                  //fillColor: Colors.black,
                  fillColor: Color.fromRGBO(153, 77, 0, 1),
                  child: Icon(
                    Icons.volunteer_activism,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    print('add to favo');
                  })),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Container(
          height: 440,
          width: double.infinity,
          child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedPage = index;
                });
              },
              itemCount: book.length,
              itemBuilder: (BuildContext c, int index) {
                return _bookSelector(index);
              }),
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                book[_selectedPage].description,
                style: TextStyle(color: Colors.black87, fontSize: 16),
              )
            ],
          ),
        ),
      ],
    );
  }
}
