import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two2/widget/top_item.dart';
//import '../provider/BOOKS.dart';
import '../provider/BOOKS_Free.dart';
import '../provider/themeprovider.dart';

class Top extends StatefulWidget {
  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> with SingleTickerProviderStateMixin {


  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<productsFree>(context, listen: false)
        .fetchandsetproducts();
  }

  PageController _pageController;

  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  /*_bookSelector(int index) {
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
        ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Container(
            child: Hero(
                tag: productsData.item[ind].imageUrl,
                child: Container(
                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(16),),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 25),
                  child: Image(
                    image: NetworkImage(productsData.item[ind].imageUrl),
                    width: 300,
                    height: 450,
                    fit: BoxFit.fill,
                  ),
                )
            ),
          ),
        ),
      ],
    ),
  );
  }*/

  Widget build(BuildContext context) {
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    return FutureBuilder(
      future: _refreshProducts(context),
      builder: (ctx, AsyncSnapshot<dynamic> snapshot) =>
      snapshot.connectionState == ConnectionState.waiting
          ? const Center(child: CircularProgressIndicator())
          :RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child:Consumer<productsFree>(
          builder: (ctx, productsData,_)=> Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                height: 440,
                width: double.infinity,
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedPage=index;
                      });
                    },
                    itemCount: productsData.item.length,
                    itemBuilder: (BuildContext c, int index){
                      return TopItem(
                        id: productsData.item[index].id,
                        imageUrl: productsData.item[index].imageUrl,
                        name: productsData.item[index].name,
                        pdf: productsData.item[index].pdf,
                        category: productsData.item[index].category,
                      );
                    }
                ),
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
                          color: Th.getColor("firstColor")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      productsData.item[_selectedPage].description,
                      style: TextStyle(color: Th.getColor("BW"), fontSize: 16),
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
