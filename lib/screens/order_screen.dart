import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/themeprovider.dart';
import '../widget/app_drawer.dart';
import '../widget/order_item.dart';
import '../provider/order.dart' show order;

class orderscreen extends StatelessWidget {
  static const routename = '/order';

  @override
  Widget build(BuildContext context) {
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    return Scaffold(
      backgroundColor: Th.getColor("thirdColor"),
      drawer: appdrawer(),
      appBar: AppBar(
        title: Text("your order"),
        backgroundColor: Th.getColor("firstColor"),
      ),
      body: FutureBuilder(
        future: Provider.of<order>(context, listen: false).fetchandsetorder(),
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(child: Text("an error occurred"));
            } else {
              return Consumer<order>(
                  builder: (ctx, orderdata, child) => ListView.builder(
                    itemBuilder: (BuildContext context, int index) =>
                        orderitem(orderdata.orders[index]),
                    itemCount: orderdata.orders.length,
                  ));
            }
          }
        },
      ),
      // drawer: appdrawer(),
    );
  }
}
