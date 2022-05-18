import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
class product with ChangeNotifier{
  final String id;
  final String product_name;
  final String photo;
  final int quantity;
  final double price;
  final String details;
  bool isfavorite;

  product({
    @required this.id,
    @required this.product_name,
    @required this.photo,
    @required this.quantity,
    @required this.price,
    @required this.details,
    this.isfavorite=false,
  });


  void _setfavvalue(bool newvalue){
    isfavorite=newvalue;
    notifyListeners();
  }
//تابع يقوم بتحويل العنصر من مفضل لغير مفضل والعكس
  Future<void> togglefavoritestate(String token,String userid)async{
    final oldstate= isfavorite;
    isfavorite=!isfavorite;
    notifyListeners();

    final url='https://almorjan-cd066-default-rtdb.firebaseio.com/userfavorites/$userid/$id.json?auth=$token';
    try{
      final res=await http.put(url, body: json.encode(isfavorite));
      if(res.statusCode>=400)
      {
        _setfavvalue(oldstate);
      }
    }catch(e){
      _setfavvalue(oldstate);
    }
  }
}