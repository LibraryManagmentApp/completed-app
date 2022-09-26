import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:two2/models/book_free.dart';
import 'package:two2/provider/BOOKS_Free.dart';
import '../provider/cart.dart';
import '../provider/lanproviders.dart';
import '../provider/themeprovider.dart';
import '../screens/cart_screen.dart';
import 'package:provider/provider.dart';
import './cart_screen.dart';
import '../widget/badge.dart';

class BookDetailesFree extends StatelessWidget {
  static const routename= '/book_details_free';

  Bookfree _editedProduct =Bookfree(
    id: null,
    name: '',
    pdf: '',
    description: '',
    imageUrl: '',
    category:'',
  );

  @override
  Widget build(BuildContext context){
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    final BookId=ModalRoute.of(context).settings.arguments as String;
    _editedProduct =
        Provider.of<productsFree>(context, listen: false).findbyid(BookId);
    var lan=Provider.of<LanguageProvider>(context,listen: true);

    return Directionality(
      textDirection: lan.isEn? TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        //drawer:appdrawer(),
        backgroundColor:Th.getColor("thirdColor"),
        appBar: AppBar(
          //automaticallyImplyLeading:false,
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
                    LikeButton(
                      size: 40,
                      circleColor: const CircleColor(
                          start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Colors.amber,
                        dotSecondaryColor: Colors.amberAccent,
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          size: 40,
                          color:
                          isLiked ? Colors.pink : Colors.grey,
                        );
                      },
                      //likeCount: 0,
                    ),
                    SizedBox(height: 70,),
                    RaisedButton(
                      child: Text(lan.getTexts("Read"),
                        style: TextStyle(fontSize:25,fontFamily: "Pacifico",fontWeight: FontWeight.bold),
                      ),
                      onPressed:()=>{},
                          //Navigator.of(context).pushNamed(PdfView.routename,arguments:_editedProduct.id),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(horizontal:50, vertical: 8),
                      color:Th.getColor("firstColor"),
                      textColor: Theme.of(context).primaryTextTheme.headline6.color,
                    ),
                    SizedBox(height: 50,),
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
