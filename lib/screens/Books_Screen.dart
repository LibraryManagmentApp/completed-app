import 'package:flutter/material.dart';
import '../provider/lanproviders.dart';
import '../screens/search_all_books_page.dart';
import '../widget/Book_item.dart';
import '../provider/BOOKS.dart';
import '../provider/cart.dart';
import '../provider/themeprovider.dart';
import '../screens/cart_screen.dart';
import 'package:provider/provider.dart';
import './cart_screen.dart';
import '../widget/badge.dart';

class BooksScreen extends StatefulWidget {
  static const routename = '/books_screen';

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {


  Future<void> _refreshProducts(BuildContext context,String categoryName) async {
    await Provider.of<products>(context, listen: false)
        .fetchandsetproductsCat(categoryName);
  }

  @override
  Widget build(BuildContext context) {
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    var lan=Provider.of<LanguageProvider>(context,listen: true);
    final routArg= ModalRoute.of(context).settings.arguments as Map<String,Object>;
    final categoryName=routArg['title'];
    return Directionality(
      textDirection: lan.isEn? TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        backgroundColor:Th.getColor("thirdColor"),
        appBar:AppBar(
          //automaticallyImplyLeading:false,
          toolbarHeight:70,
          title:Padding(
            padding:const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
            Text(categoryName,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Pacifico",)),
            SizedBox(width: 30,),
                IconButton(
                  padding: EdgeInsets.only(right:8),
                  icon:Icon(Icons.search),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllBooksPage())
                  ),
                ),

                Consumer<cart>(
              child: IconButton(
                icon: Icon(Icons.shopping_cart,
                  size: 30,
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(cartscreen.routename),
              ),
              builder: (_, cart, ch) =>
                  badge(value: cart.itemcount.toString(), child: ch),
            ),
              ],
        ),
          ),
          backgroundColor: Th.getColor("firstColor"),
        ),
        body: FutureBuilder(
          future: _refreshProducts(context,categoryName),
          builder: (ctx, AsyncSnapshot<dynamic> snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
          ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                onRefresh: () => _refreshProducts(context,categoryName),
           child:Consumer<products>(
          builder: (ctx, productsData, _) => GridView.builder(
              padding: EdgeInsets.all(10),
               gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:200,
                childAspectRatio:0.70,
                crossAxisSpacing: 40,
                mainAxisSpacing: 20,
              ),
            itemBuilder: (ctx,index){
              return BookItem(
                  id: productsData.item[index].id,
                  imageUrl: productsData.item[index].imageUrl,
                  name: productsData.item[index].name,
                  price: productsData.item[index].price,
                );
            },
            itemCount: productsData.item.length,
          ),

        ),
          ),
        ),
      ),
    );

  }
}
