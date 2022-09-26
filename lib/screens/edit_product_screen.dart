import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../provider/BOOKS.dart';
import '../provider/lanproviders.dart';
import '../provider/themeprovider.dart';

class EditProductScreen extends StatefulWidget {
  static const routename = '/edit';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _categoryFocusNode = FocusNode();
  final _discriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Book _editedProduct =Book(
    id: null,
    name: '',
    price: 0,
    description: '',
    imageUrl: '',
    category:'',
  );
  var _initialValue = {
    'name': '',
    'price': '',
    'category':'',
    'imageUrl': '',
    'description':'',
  };
  var _isLoading = false;
  var _isInit = true;


  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit){
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<products>(context, listen: false).findbyid(productId);
        _initialValue = {
          'name': _editedProduct.name,
          'price': _editedProduct.price.toString(),
          'category': _editedProduct.category.toString(),
          'description':_editedProduct.description,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
      _isInit = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _discriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _categoryFocusNode.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
          !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      await Provider.of<products>(context, listen: false)
          .updateproduct(_editedProduct.id,_editedProduct);
    } else {
      try {
        await Provider.of<products>(context, listen: false)
            .addproduct(_editedProduct);

      } catch (e) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("An error occured!"),
            content: Text("Something went wrong.."),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text("Okay!!"))
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    var lan=Provider.of<LanguageProvider>(context,listen: true);

    return Directionality(
      textDirection: lan.isEn? TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        backgroundColor:Th.getColor("thirdColor"),
          //drawer:appdrawer(),
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: Th.getColor("secondaryColor"),
            title: _editedProduct.id != null
                ? Text(lan.getTexts("Edit Books"),
              style: TextStyle(fontFamily: "Pacifico",fontWeight: FontWeight.bold),
            )
                : Text(lan.getTexts("Add Book"),
              style: TextStyle(fontFamily: "Pacifico",fontWeight: FontWeight.bold),
            ),
            actions: [
              Row(
                children: [
                  IconButton(onPressed: _saveForm, icon: const Icon(Icons.save)),
                  SizedBox(width: 15),
                ],
              )
            ],
          ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    cursorColor:Th.getColor("secondaryColor"),
                    initialValue: _initialValue['name'],
                    decoration: InputDecoration(
                        labelText:lan.getTexts("Title"),labelStyle:TextStyle(
                      color: Th.getColor("BW54"),
                    )
                    ),
                    style: TextStyle(color: Th.getColor("BW")),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return lan.getTexts("Please Enter The Title.");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Book(
                        name: value,
                        id: _editedProduct.id,
                        imageUrl: _editedProduct.imageUrl,
                        price: _editedProduct.price,
                        category:_editedProduct.category,
                        description:_editedProduct.description,
                      );
                    },
                  ),
                  TextFormField(
                    initialValue: _initialValue['price'],
                    decoration:InputDecoration(labelText:lan.getTexts("Price"),labelStyle:TextStyle(
                      color: Th.getColor("BW54"),
                    )),
                    textInputAction: TextInputAction.next,
                    style: TextStyle(color: Th.getColor("BW")),
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_categoryFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return lan.getTexts("Please Enter A Price.");
                      }
                      if (double.tryParse(value) == null) {
                        return lan.getTexts("Please Enter A Valid Price.");
                      }
                      if (double.parse(value) <= 0) {
                        return lan.getTexts("Please Enter A Number Grater Than Zero.");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Book(
                        name: _editedProduct.name,
                        id: _editedProduct.id,
                        imageUrl: _editedProduct.imageUrl,
                        price: double.parse(value),
                        category: _editedProduct.category,
                        description:_editedProduct.description,
                      );
                    },
                  ),
                  TextFormField(
                    initialValue: _initialValue['category'],
                    decoration:InputDecoration(labelText: lan.getTexts("Category"),labelStyle:TextStyle(
                      color: Th.getColor("BW54"),
                    )),
                    style: TextStyle(color: Th.getColor("BW")),
                    textInputAction: TextInputAction.next,
                    focusNode: _categoryFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_discriptionFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return lan.getTexts("Please Enter A Category.");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Book(
                        category: value,
                        name: _editedProduct.name,
                        id: _editedProduct.id,
                        imageUrl: _editedProduct.imageUrl,
                        price: _editedProduct.price,
                        description:_editedProduct.description,
                      );
                    },
                  ),
                  TextFormField(
                    initialValue: _initialValue['description'],
                    style: TextStyle(color: Th.getColor("BW")),
                    decoration: InputDecoration(labelText:lan.getTexts("description"),labelStyle:TextStyle(
                      color: Th.getColor("BW54"),
                    )),
                    textInputAction: TextInputAction.next,
                    focusNode: _discriptionFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return lan.getTexts("Please Enter The description.");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Book(
                        name:_editedProduct.name,
                        id: _editedProduct.id,
                        imageUrl: _editedProduct.imageUrl,
                        price: _editedProduct.price,
                        category: _editedProduct.category,
                        description:value,
                      );
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Th.getColor("BW54")),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ?  Text(lan.getTexts("Enter Url"),style: TextStyle(color:Th.getColor("BW54") ),)
                            : FittedBox(
                          child: Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _imageUrlController,
                          decoration:
                          InputDecoration(labelText:lan.getTexts("Image URL"),labelStyle:TextStyle(
                            color: Th.getColor("BW54"),
                          )),
                          keyboardType: TextInputType.url,
                          style: TextStyle(color: Th.getColor("BW")),
                          focusNode: _imageUrlFocusNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return lan.getTexts("Please Enter A Image URL.");
                            }
                            if (!value.startsWith('http') ||
                                !value.startsWith('https')) {
                              return lan.getTexts("Please Enter A Valid URL.");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Book(
                              name:_editedProduct.name,
                              id: _editedProduct.id,
                              imageUrl: value,
                              price: _editedProduct.price,
                              category: _editedProduct.category,
                              description:_editedProduct.description,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
