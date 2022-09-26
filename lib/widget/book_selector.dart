import 'package:flutter/material.dart';

class BookSelector extends StatefulWidget {
  final int index;
  final String id;
  final String imageUrl;
  final String name;
  final String pdf;
  final String category;
  final String description;

  //const TopItem({ this.description,this.id, this.imageUrl, this.name, this.pdf, this.category});
  const BookSelector({Key key,this.description,this.id, this.imageUrl, this.name, this.pdf, this.category, this.index}) : super(key: key);

  @override
  State<BookSelector> createState() => _BookSelectorState();
}

class _BookSelectorState extends State<BookSelector> {

  PageController _pageController;

   @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }
  @override
  Widget build(BuildContext context) {
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
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(153, 77, 0, 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.fromLTRB(10, 10,10, 25),
            child: Center(
                child: Hero(
                    tag: widget.imageUrl,
                    child:  Image(
                          image: NetworkImage(widget.imageUrl),
                          width: 300,
                          height: 450,
                          fit: BoxFit.fill,
                        ),)),
          ),
          Positioned(
              bottom: 0,
              left: 30,
              child: RawMaterialButton(
                  padding: EdgeInsets.all(15),
                  shape: CircleBorder(),
                  elevation: 3,
                  //fillColor: Colors.black,
                  fillColor: Color.fromRGBO(153, 77, 0, 1),
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    print('add to cart');
                  })),
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
}