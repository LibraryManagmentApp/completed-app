import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two2/screens/Book_detailes_free.dart';
import 'package:two2/widget/book_selector.dart';
import 'package:two2/widget/top_item.dart';
//import '../provider/BOOKS.dart';
import '../provider/BOOKS_Free.dart';
import '../provider/lanproviders.dart';

class Toop extends StatefulWidget {
  


  @override
  State<Toop> createState() => _ToopState();
}

class _ToopState extends State<Toop>with SingleTickerProviderStateMixin {

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

  @override
  Widget build(BuildContext context) {
    var lan=Provider.of<LanguageProvider>(context,listen: true);
    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, AsyncSnapshot<dynamic> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            :RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
        child: Consumer<productsFree>(
          builder: (ctx, productsData,_)=>Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
        onTap: (){
         Navigator.of(ctx).pushNamed(BookDetailesFree.routename,arguments:productsData.item[_selectedPage].id);
        },
              child: Container(
                      height: 440,
                      width: double.infinity,
                      child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            //setState(() {
                              _selectedPage = index;
                            //});
                          },
                          itemCount: productsData.item.length,//book.length,
                          itemBuilder: (BuildContext c, int index) {
                            return BookSelector(index: index,id: productsData.item[index].id,
                      imageUrl: productsData.item[index].imageUrl,
                      name: productsData.item[index].name,
                      pdf: productsData.item[index].pdf,
                      category: productsData.item[index].category,
                      description:productsData.item[index].description,);
                          }),
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
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      productsData.item[_selectedPage].description,
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    )
                  ],
                ),
              ),
          ],
        ),
        )
      )),
    );         
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   var Th=Provider.of<ThemeProvider>(context,listen: true);

  //   return FutureBuilder(
  //     future: _refreshProducts(context),
  //     builder: (ctx, AsyncSnapshot<dynamic> snapshot) =>
  //     snapshot.connectionState == ConnectionState.waiting
  //         ? const Center(child: CircularProgressIndicator())
  //         :RefreshIndicator(
  //       onRefresh: () => _refreshProducts(context),
  //       child:Consumer<productsFree>(
  //         builder: (ctx, productsData,_)=> ListView.builder(
  //             padding: EdgeInsets.all(10),
  //             itemCount: productsData.item.length,
  //             itemBuilder: (BuildContext c, int index){
  //               return TopItem(
  //                 id: productsData.item[index].id,
  //                 imageUrl: productsData.item[index].imageUrl,
  //                 name: productsData.item[index].name,
  //                 pdf: productsData.item[index].pdf,
  //                 category: productsData.item[index].category,
  //                 description:productsData.item[index].description,
  //               );
  //             }
  //         ),
  //       ),
  //     ),
  //   );
  // }
//}