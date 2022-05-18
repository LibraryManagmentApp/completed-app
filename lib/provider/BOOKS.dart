import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';
import 'BOOK.dart';
class products with ChangeNotifier {
  List<product> _item = [];
  String authtoken;
  String userid;

//(نستفيد منعا في البروكسي بروفايدر)تابع يقوم بارجاع البيانات
  getdata(String authtok, String uid, List<product> prodcts) {
    authtoken = authtok;
    userid = uid;
    _item = prodcts;
    notifyListeners();
  }

  //تابع استخدمناه لاننا عرفنا المنتجات باريفت
  List<product> get item {
    return [..._item];
  }

  List<product> get favoritesitems {
    return _item.where((proditem) => proditem.isfavorite).toList();
  }

  product findbyid(String id) {
    return _item.firstWhere((prod) => prod.id ==id);
  }

  //تجلب البيانات كم الداتا
  Future<void> fetchandsetproducts([bool filterbyuser = false]) async {
    final filterstring =
    filterbyuser ? 'orderBy="creatorId"&equalTo="$userid"' : '';
    var url = 'https://almorjan-cd066-default-rtdb.firebaseio.com/products.json?auth=$authtoken&$filterstring';
    try {
      final res = await http.get(url);
      final extractdata = json.decode(res.body) as Map<String, dynamic>;
      if (extractdata == null) {
        return;
      }
      url = 'https://almorjan-cd066-default-rtdb.firebaseio.com/userfavorites/$userid.json?auth=$authtoken';
      final favres = await http.get(url);
      final favdata = json.decode(favres.body) ;
      final List<product> loadedproducts = [];
      extractdata.forEach((prodid, proddata) {
        loadedproducts.add(
          product(
            id: prodid,
            product_name: proddata['product_name'],
            photo: proddata['photo'],
            quantity: proddata['quantity'],
            price: proddata['price'],
            details: proddata['details'],
            isfavorite: favdata==null?false:favdata[prodid]??false,
          ),
        );
      });
      _item = loadedproducts;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addproduct(product prod) async {
    final url = 'https://almorjan-cd066-default-rtdb.firebaseio.com/products.json?auth=$authtoken';
    try {
      //نضيف البيانات الى السيرفر
      final res = await http.post(url,
          body: json.encode({
            'product_neme': prod.product_name,
            'quantity': prod.quantity,
            'price': prod.price,
            'details': prod.details,
            'creatorId':userid,
            'photo': prod.photo,
          }));
      //عطي البيانات الى item_
      final newproduct = product(
        id: json.decode(res.body)['name'],
        product_name: prod.product_name,
        photo: prod.photo,
        quantity: prod.quantity,
        price: prod.price,
        details: prod.details,
      );
      _item.add(newproduct);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateproduct(String id, product newproduct) async {
    final prodindex = _item.indexWhere((prod) => prod.id == id);
    if (prodindex >= 0) {
      //العنصر موجود
      final url =
          'https://almorjan-cd066-default-rtdb.firebaseio.com/products/$id.json?auth=$authtoken';
      await http.patch(url,
          body: json.encode({
            'quantity': newproduct.quantity,
            'photo': newproduct.photo,
            'price': newproduct.price,
            'details': newproduct.details,
          }));
      _item[prodindex] = newproduct;
      notifyListeners();
    }else{
      print("....");
    }
  }

  Future<void> deleteproduct(String id) async {
    final url = 'https://almorjan-cd066-default-rtdb.firebaseio.com/products/$id.json?auth=$authtoken';
    final existingproductindex = _item.indexWhere((prod) => prod.id == id);
    var existingproduct = _item[existingproductindex];
    _item.removeAt((existingproductindex)); //يقوم بحذف العنصر من التطبيق
    notifyListeners();
    final res = await http.delete(url);
    if (res.statusCode >= 400) {
      _item.insert(existingproductindex, existingproduct);
      notifyListeners();
      throw HttpException('could not delete product');
    }
    existingproduct = null; //
  }
}
