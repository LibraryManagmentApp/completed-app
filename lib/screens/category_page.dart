import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data_cat.dart';
import '../provider/lanproviders.dart';
import '../widget/card_scroll_view.dart';
import '../screens/Books_Screen.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<CategoryPage> createState()=> _CategoryPageState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRadio = cardAspectRatio * 1.2;

class _CategoryPageState extends State<CategoryPage> {

  void selectbook(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(BooksScreen.routename);
  }

  double currentPage = category.length - 1.0;
  @override
  Widget build(BuildContext context) {
    PageController _pageController =
    PageController(initialPage: category.length - 1);

    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });
    var lan=Provider.of<LanguageProvider>(context,listen: true);

    return Directionality(
      textDirection: lan.isEn? TextDirection.ltr:TextDirection.rtl,
      child: Stack(
            children:[
              CardScrollView(currentPage),
              Positioned.fill(
                  child: GestureDetector(
                    onTap: (){
                    switch(currentPage?.toInt()){
                      case 3:{
                        Navigator.of(context).pushNamed(BooksScreen.routename,arguments:{'id': 'c4', 'title':lan.getTexts('Scientific Books'),});
                      }break;
                      case 2:{
                        Navigator.of(context).pushNamed(BooksScreen.routename,arguments:{'id': 'c3', 'title':lan.getTexts('Story'),});
                      }break;
                      case 1:{
                        Navigator.of(context).pushNamed(BooksScreen.routename,arguments:{'id': 'c2', 'title':lan.getTexts('Novels'),});
                      }break;
                      case 0:{
                        Navigator.of(context).pushNamed(BooksScreen.routename,arguments:{'id': 'c1', 'title':lan.getTexts('Childrens Books'),});
                      }break;
                      default:{
                        print("This Is Default Case");
                      }break;
                    }},
                    child: PageView.builder(
                        itemCount: category.length,
                        controller:_pageController,
                        reverse: true,
                        itemBuilder: (context,index){
                          return Container();
                        }),
                  )
              )
            ],
          ),
    );

  }
}