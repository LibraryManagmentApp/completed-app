import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import '../constant.dart';
import '../provider/BOOKS.dart';
import '../provider/cart.dart';
import '../provider/lanproviders.dart';
import '../provider/themeprovider.dart';
import '../screens/cart_screen.dart';
import '../widget/app_drawer.dart';
import 'package:provider/provider.dart';
import './cart_screen.dart';
import '../screens/cart_screen.dart';
import '../provider/order.dart';
import '../screens/order_screen.dart';
import '../screens/category_page.dart';
import '../widget/badge.dart';
import '../models/book.dart';

class BookDetailes extends StatelessWidget {
  static const routename = '/book_details';

  Book _editedProduct =Book(
    id: null,
    name: '',
    price:0,
    description: '',
    imageUrl: '',
    category:'',
  );

  @override
  Widget build(BuildContext context){
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    var lan=Provider.of<LanguageProvider>(context,listen: true);

    final BookId=ModalRoute.of(context).settings.arguments as String;
    _editedProduct =
        Provider.of<products>(context, listen: false).findbyid(BookId);

    //final selectbook= book.firstWhere((book) => book.id==BookId);

    return Directionality(
      textDirection: lan.isEn? TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        //drawer:appdrawer(),
        backgroundColor:Th.getColor("thirdColor"),
        appBar: AppBar(
          toolbarHeight:70,
          title:Padding(
            padding:const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text(_editedProduct.name,style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,fontFamily: "Pacifico",)),
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
          backgroundColor:Th.getColor("firstColor"),
        ),
        body: Column(
          children: [
            Stack(
              children:[
                Container(
                height: 300,
                width: double.infinity,
                child: Image.network(_editedProduct.imageUrl,fit: BoxFit.cover,),
              ),
                Column(
                  children: [
                    SizedBox(
                      height: 230,
                    ),
                    Container(
                      alignment:AlignmentDirectional.center,
                      child: Text(_editedProduct.category,style: TextStyle(color:Colors.black,fontSize:20,fontWeight: FontWeight.bold,fontFamily: "Pacifico",),),
                      height: 70,
                      width: 100,
                      color: Colors.black12,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 25),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(lan.getTexts("Description"),style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Th.getColor("secondaryColor")),),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Th.getColor("thirdColor"),
                        border: Border.all(color: Th.getColor("firstColor")),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      height: 200,
                      width:300 ,
                      child: ListView.builder(
                        itemBuilder: (ctx,index)=> Card(
                          color:Colors.white60,
                          child: Container(child:Text(_editedProduct.description,style: TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                        itemCount:_editedProduct.description.length,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 70,),
                    SizedBox(height: 70,),
                    RaisedButton(
                      child: Text(lan.getTexts("Add To Cart"),
                        style: TextStyle(fontSize:15,fontFamily: "Pacifico",fontWeight: FontWeight.bold),
                      ),
                      onPressed:(){},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(horizontal:30, vertical:15),
                      color:Th.getColor("firstColor"),
                      textColor: Theme.of(context).primaryTextTheme.headline6.color,
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
