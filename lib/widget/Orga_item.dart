import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/BOOKS.dart';
import '../provider/lanproviders.dart';
import '../provider/themeprovider.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;

  const UserProductItem(
      this.id,
      this.name,
      this.imageUrl,
      );

  @override
  Widget build(BuildContext context) {
    final scafold = Scaffold.of(context);
    var lan=Provider.of<LanguageProvider>(context,listen: true);
    var Th=Provider.of<ThemeProvider>(context,listen: true);

    return ListTile(
        title: Text(name,style: TextStyle(color: Th.getColor("BW")),),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                color: Th.getColor("BW38"),
                onPressed: () => Navigator.of(context).pushNamed(
                  EditProductScreen.routename,
                  arguments:id,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await Provider.of<products>(context, listen: false)
                        .deleteproduct(id);
                  } catch (e) {
                    scafold.showSnackBar(
                      const SnackBar(
                          content: Text("Deleting Failed!!",textAlign: TextAlign.center
                          )),
                    );
                  }
                },
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      );
  }
}
