import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two2/models/book_free.dart';
import '../provider/BOOKS_Free.dart';
import '../provider/themeprovider.dart';

class EditProductScreenFree extends StatefulWidget {
  static const routename = '/editfree';

  @override
  State<EditProductScreenFree> createState() => _EditProductScreenFreeState();
}

class _EditProductScreenFreeState extends State<EditProductScreenFree> {
  final _pdfFocusNode = FocusNode();
  final _categoryFocusNode = FocusNode();
  final _discriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _pdfController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  Bookfree _editedProduct =Bookfree(
    id: null,
    name: '',
    pdf:'',
    description: '',
    imageUrl: '',
    category:'',
  );

  var _initialValue = {
    'name': '',
    'pdf': '',
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
    //_pdfFocusNode.addListener(_updatePdf);
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit){
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<productsFree>(context, listen: false).findbyid(productId);
        _initialValue = {
          'name': _editedProduct.name,
          'category': _editedProduct.category.toString(),
          'description':_editedProduct.description,
          'imageUrl': '',
          'pdf': _editedProduct.pdf,
        };
        _imageUrlController.text = _editedProduct.imageUrl;
        //_pdfController.text = _editedProduct.pdf;
      }
      _isInit = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    //_pdfFocusNode.removeListener(_updatePdf);
    _pdfFocusNode.dispose();
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

   /* void _updatePdf() {
    if (!_pdfFocusNode.hasFocus) {
      if ((!_pdfController.text.endsWith('.pdf'))) {
        return;
      }
      setState(() {});
    }
  }*/

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
      await Provider.of<productsFree>(context, listen: false)
          .updateproduct(_editedProduct.id,_editedProduct);
    } else {
      try {
        await Provider.of<productsFree>(context, listen: false)
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
    return Scaffold(
      backgroundColor:Th.getColor("thirdColor"),
      //drawer:appdrawer(),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Th.getColor("secondaryColor"),
        title: _editedProduct.id != null
            ? Text("Edit Books Free ",
          style: TextStyle(fontFamily: "Pacifico",fontWeight: FontWeight.bold),
        )
            : Text("Add Book Free",
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
                    labelText:"Title",labelStyle:TextStyle(
                  color: Th.getColor("BW54"),
                )
                ),
                style: TextStyle(color: Th.getColor("BW")),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_pdfFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter The Title.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Bookfree(
                    name: value,
                    id: _editedProduct.id,
                    imageUrl: _editedProduct.imageUrl,
                    pdf: _editedProduct.pdf,
                    category:_editedProduct.category,
                    description:_editedProduct.description,
                  );
                },
              ),

            Row(
            crossAxisAlignment: CrossAxisAlignment.end,
             children: [
                Expanded(
            child: TextFormField(
              initialValue: _initialValue['pdf'],
              decoration:InputDecoration(suffixIcon:Icon(Icons.book),labelText:"Pdf",labelStyle:TextStyle(
                color: Th.getColor("BW54"),
              )),
              textInputAction: TextInputAction.next,
              style: TextStyle(color: Th.getColor("BW")),
              keyboardType: TextInputType.number,
              focusNode: _pdfFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_categoryFocusNode);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return "Please Select A Pdf.";
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Bookfree(
                  name: _editedProduct.name,
                  id: _editedProduct.id,
                  imageUrl: _editedProduct.imageUrl,
                  pdf:value,
                  category: _editedProduct.category,
                  description:_editedProduct.description,
                );
              },
            ),
          ),
              ],
            ),

              TextFormField(
                initialValue: _initialValue['category'],
                decoration:InputDecoration(labelText: "Category",labelStyle:TextStyle(
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
                    return "Please Enter A Category.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Bookfree(
                    category: value,
                    name: _editedProduct.name,
                    id: _editedProduct.id,
                    imageUrl: _editedProduct.imageUrl,
                    pdf: _editedProduct.pdf,
                    description:_editedProduct.description,
                  );
                },
              ),
              TextFormField(
                initialValue: _initialValue['description'],
                style: TextStyle(color: Th.getColor("BW")),
                decoration: InputDecoration(labelText:"description",labelStyle:TextStyle(
                  color: Th.getColor("BW54"),
                )),
                textInputAction: TextInputAction.next,
                focusNode: _discriptionFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter The description.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Bookfree(
                    name:_editedProduct.name,
                    id: _editedProduct.id,
                    imageUrl: _editedProduct.imageUrl,
                    pdf: _editedProduct.pdf,
                    category:_editedProduct.category,
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
                        ?  Text("Enter Url",style: TextStyle(color:Th.getColor("BW54") ),)
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
                      InputDecoration(labelText:"Image URL",labelStyle:TextStyle(
                        color: Th.getColor("BW54"),
                      )),
                      keyboardType: TextInputType.url,
                      style: TextStyle(color: Th.getColor("BW")),
                      focusNode: _imageUrlFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Enter A Image URL.";
                        }
                        if (!value.startsWith('http') ||
                            !value.startsWith('https')) {
                          return "Please Enter A Valid URL.";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Bookfree(
                          name:_editedProduct.name,
                          id: _editedProduct.id,
                          imageUrl: value,
                          pdf: _editedProduct.pdf,
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
    );
  }
}
