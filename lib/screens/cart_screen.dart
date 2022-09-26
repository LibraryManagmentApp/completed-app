import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart' show cart;
import '../provider/themeprovider.dart';
import '../widget/cart_item.dart';
import '../provider/order.dart';

class cartscreen extends StatelessWidget {
  static const routename = '/cart';
  @override
  Widget build(BuildContext context) {
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    final card = Provider.of<cart>(context);
    return Scaffold(
      backgroundColor: Th.getColor("thirdColor"),
        appBar: AppBar(
          title: Text("Your Cart"),
          backgroundColor:Th.getColor("firstColor"),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(), //المساحة الممكنة
                    Chip(
                      label: Text(
                        '\$${card.totalamount.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                .color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    Orderbutton(cartt: card),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: card.items.length,
                itemBuilder: ( ctx, int index) => CartItem(
                  card.items.values.toList()[index].id,
                  card.items.keys.toList()[index],
                  card.items.values.toList()[index].price,
                  card.items.values.toList()[index].quantity,
                  card.items.values.toList()[index].product_name,

                ),
              ),
            ),
          ],
        )
    );
  }
}

class Orderbutton extends StatefulWidget {
  final cart cartt;

  const Orderbutton({ @required this.cartt}) ;

  @override
  _OrderbuttonState createState() => _OrderbuttonState();
}

class _OrderbuttonState extends State<Orderbutton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed: (widget.cartt.totalamount <= 0 || _isLoading)
          ? null
          : () async {
        setState(() {
          _isLoading = true;
        });

        await Provider.of<order>(context, listen: false)
            .addorder(widget.cartt.items.values.toList(), widget.cartt.totalamount);
        setState(() {
          _isLoading = false;
        });
        widget.cartt.clear();
      },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
