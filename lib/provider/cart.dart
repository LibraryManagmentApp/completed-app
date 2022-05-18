import 'package:flutter/material.dart';

class cartitem {
  final String id;
  final String product_name;
  final int quantity;
  final int price;

  cartitem({
    @required this.id,
    @required this.product_name,
    @required this.quantity,
    @required this.price,
  });
}

class cart with ChangeNotifier {
  Map<String, cartitem> _items = {};

  Map<String, cartitem> get items {
    return {..._items};
  }


  int get itemcount {
    return _items.length;
  }

  double get totalamount {
    var total = 0.0;
    _items.forEach((key, cartitemm) {
      total += cartitemm.price * cartitemm.quantity;
    });
    return total;
  }

  void additem(String productid, double price, String title) {
    if (_items.containsKey(productid)) {
      _items.update(productid, (exisitingcartitem) =>
          cartitem(
              id: exisitingcartitem.id,
              product_name: exisitingcartitem.product_name,
              quantity: exisitingcartitem.quantity + 1,
              price: exisitingcartitem.price
          ),
      );
    }
    else {
      _items.putIfAbsent(
        productid,
            () =>
            cartitem(
              id: DateTime.now().toString(),
              product_name: title,
              quantity: 1,
              price: price.toInt(),
            ),
      );
    }
    notifyListeners();
  }

  void removitem(String productid) {
    _items.remove(productid);
    notifyListeners();
  }

  void removesingleitem(String productid) {
    if (!_items.containsKey(productid)) {
      return;
    }
    if (_items[productid].quantity > 1) {
      _items.update(
        productid,
            (exisitingcartitem) =>
            cartitem(
                id: exisitingcartitem.id,
                product_name: exisitingcartitem.product_name,
                quantity: exisitingcartitem.quantity - 1,
                price: exisitingcartitem.price
            ),
      );
    } else {
      _items.remove(productid);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}

