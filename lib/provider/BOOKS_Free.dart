import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:two2/models/book_free.dart';
import 'dart:convert';
import '../models/http_exception.dart';

class productsFree with ChangeNotifier {
  List<Bookfree> _item = [];
  String authtoken;
  String userid;

//(نستفيد منعا في البروكسي بروفايدر)تابع يقوم بارجاع البيانات
  getdata(String authtok, String uid, List<Bookfree> prodcts) {
    authtoken = authtok;
    userid = uid;
    _item = prodcts;
    notifyListeners();
  }

  //تابع استخدمناه لاننا عرفنا المنتجات باريفت
  List<Bookfree> get item {
    return [..._item];
  }

  List<Bookfree> get favoritesitems {
    return _item.where((proditem) => proditem.isfavorite).toList();
  }

  Bookfree findbyid(String id) {
    return _item.firstWhere((prod) => prod.id ==id);
  }

  List<Bookfree> findbycategory(String category){
    return _item.where((prod) => prod.category ==category);
  }

  List<Bookfree> BooksList(){
    List<Bookfree> R;
    R= fetchandsetproductsNamed() as List<Bookfree>;
    return R;
  }

  Future<List<Bookfree>> fetchandsetproductsNamed() async {
    //final filterstring = filterbyuser ? 'orderBy="creatorId"&equalTo="$userid"' : '';
    var url = 'https://thisone-186e0-default-rtdb.firebaseio.com/productsfree.json?auth=$authtoken';
    try {
      final res = await http.get(Uri.parse(url));
      final extractdata = json.decode(res.body) as
      Map<String, dynamic>;

      final List<Bookfree> loadedproducts = [];
      extractdata.forEach((prodid, proddata) {
        loadedproducts.add(
          Bookfree(
            id: prodid,
            name: proddata['name'],
            imageUrl: proddata['imageUrl'],
            category: proddata['category'],
            pdf:proddata['pdf'],
            description: proddata['description'],
          ),
        );
      });
      _item = loadedproducts;
      notifyListeners();
      return _item;
    } catch (e) {
      throw e;
    }
  }

  //تجلب البيانات كم الداتا
  Future<void> fetchandsetproducts([bool filterByUser = false]) async {
    //final filterstring = filterbyuser ? 'orderBy="creatorId"&equalTo="$userid"' : '';
    var url = 'https://thisone-186e0-default-rtdb.firebaseio.com/productsfree.json?auth=$authtoken';
    try {
      final res = await http.get(Uri.parse(url));
      final extractdata = json.decode(res.body) as Map<String, dynamic>;
      if (extractdata == null){
        return;
      }
      url = 'https://thisone-186e0-default-rtdb.firebaseio.com/userfavorites/$userid.json?auth=$authtoken';
      final favres = await http.get(Uri.parse(url));
      final favdata = json.decode(favres.body) ;

      final List<Bookfree> loadedproducts = [];
      extractdata.forEach((prodid, proddata) {
        loadedproducts.add(
          Bookfree(
            id: prodid,
            name: proddata['name'],
            imageUrl: proddata['imageUrl'],
            category:proddata['category'] ,
            pdf:proddata['pdf'],
            description: proddata['description'],
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

  Future<void> addproduct(Bookfree prod) async {
    final url = 'https://thisone-186e0-default-rtdb.firebaseio.com/productsfree.json?auth=$authtoken';
    try {
      //نضيف البيانات الى السيرفر
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'name': prod.name,
            'category':prod.category,
            'description': prod.description,
            'pdf':prod.pdf,
            'creatorId':userid,
            'imageUrl': prod.imageUrl,
          }));
      //عطي البيانات الى item_
      final newproduct = Bookfree(
        id: json.decode(res.body)['name'],
        name: prod.name,
        category:prod.category,
        pdf:prod.pdf,
        description: prod.description,
        imageUrl: prod.imageUrl,
      );
      _item.add(newproduct);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateproduct(String id, Bookfree newproduct) async {
    final prodindex = _item.indexWhere((prod) => prod.id == id);
    if (prodindex >= 0) {
      //العنصر موجود
      final url =
          'https://thisone-186e0-default-rtdb.firebaseio.com/productsfree/$id.json?auth=$authtoken';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'name': newproduct.name,
            'imageUrl': newproduct.imageUrl,
            'category':newproduct.category,
            'pdf': newproduct.pdf,
            'description': newproduct.description,
          }));
      _item[prodindex] = newproduct;
      notifyListeners();
    }else{
      print("....");
    }
  }

  Future<void> deleteproduct(String id) async {
    final url = 'https://thisone-186e0-default-rtdb.firebaseio.com/productsfree/$id.json?auth=$authtoken';
    final existingproductindex = _item.indexWhere((prod) => prod.id == id);
    var existingproduct = _item[existingproductindex];
    _item.removeAt((existingproductindex)); //يقوم بحذف العنصر من التطبيق
    notifyListeners();
    final res = await http.delete(Uri.parse(url));
    if (res.statusCode >= 400) {
      _item.insert(existingproductindex, existingproduct);
      notifyListeners();
      throw HttpException('could not delete product');
    }
    existingproduct = null; //
  }
}
