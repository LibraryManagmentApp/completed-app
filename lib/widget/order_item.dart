import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider/order.dart' as ord;

class orderitem extends StatelessWidget {
  final ord.orderitem order;

  const orderitem(this.order);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ExpansionTile(
        title: Text('\$${order.amount}'),
        subtitle: Text(DateFormat('dd/MM/yy hh:mm').format(order.dateTime)),
        children: order.products
            .map((prod) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              prod.product_name,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '${prod.quantity}x \$${prod.price}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.orange,
              ),
            ),
          ],
        ))
            .toList(),
      ),
    );
  }
}
