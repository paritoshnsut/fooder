import 'package:flutter/material.dart';
import 'package:rest_app/models/items.dart';
import 'package:provider/provider.dart';

class FormEdit extends StatefulWidget {
  static const routeName = '/form-edit';
  @override
  _FormEditState createState() => _FormEditState();
}

class _FormEditState extends State<FormEdit> {
  final _priceFocusNode = FocusNode();
  final _catFocusNode = FocusNode();

  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = new Item(
    id: null,
    name: '',
    price: 0,
    catId: '',
    imgUrl: '',
  );

  var _initValues = {
    'catId': '',
    'name': '',
    'price': '',
    'imgUrl': '',
  };

  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Items>(context, listen: false).findById(productId);
        _initValues = {
          'catId': _editedProduct.catId,
          'name': _editedProduct.name,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imgUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();

    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
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

  void _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_editedProduct.id != null) {


       setState(() {
         _isLoading=true;
       });
      await Provider.of<Items>(context, listen: false)
          .updateItem(_editedProduct.id, _editedProduct);

       setState(() {
         _isLoading=false;
       });




    } else {
      try {
        setState(() {
          _isLoading = true;
        });

        await Provider.of<Items>(context, listen: false)
            .addItem(_editedProduct);
        // print("Item added");

      } catch (error) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Error Occurred!"),
                content: Text("Something went wrong!"),
                actions: [
                  RaisedButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      })
                ],
              );
            });
      } finally {
        setState(() {
          _isLoading = false;
        });

      }

    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: _isLoading
                  ? Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    )
                  : Form(
                      key: _form,
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                            initialValue: _initValues['name'],
                            decoration: InputDecoration(labelText: 'Title'),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_priceFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please provide a value.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Item(
                                  name: value,
                                  price: _editedProduct.price,
                                  imgUrl: _editedProduct.imgUrl,
                                  id: _editedProduct.id,
                                  isfav: _editedProduct.isfav);
                            },
                          ),
                          TextFormField(
                            initialValue: _initValues['price'],
                            decoration: InputDecoration(labelText: 'Price'),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            focusNode: _priceFocusNode,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_catFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a price.';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid number.';
                              }
                              if (double.parse(value) <= 0) {
                                return 'Please enter a number greater than zero.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Item(
                                  name: _editedProduct.name,
                                  price: double.parse(value),
                                  imgUrl: _editedProduct.imgUrl,
                                  id: _editedProduct.id,
                                  isfav: _editedProduct.isfav);
                            },
                          ),
                          TextFormField(
                            initialValue: _initValues['catId'],
                            decoration:
                                InputDecoration(labelText: 'Category ID'),
                            keyboardType: TextInputType.text,
                            focusNode: _catFocusNode,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a valid Id.';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Item(
                                name: _editedProduct.name,
                                price: _editedProduct.price,
                                catId: value,
                                imgUrl: _editedProduct.imgUrl,
                                id: _editedProduct.id,
                                isfav: _editedProduct.isfav,
                              );
                            },
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.only(
                                  top: 8,
                                  right: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: _imageUrlController.text.isEmpty
                                    ? Text('Enter a URL')
                                    : FittedBox(
                                        child: Image.network(
                                          _imageUrlController.text,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Image URL'),
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.done,
                                  controller: _imageUrlController,
                                  focusNode: _imageUrlFocusNode,
                                  onFieldSubmitted: (_) {
                                    _saveForm();
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter an image URL.';
                                    }
                                    if (!value.startsWith('http') &&
                                        !value.startsWith('https')) {
                                      return 'Please enter a valid URL.';
                                    }
                                    if (!value.endsWith('.png') &&
                                        !value.endsWith('.jpg') &&
                                        !value.endsWith('.jpeg')) {
                                      return 'Please enter a valid image URL.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _editedProduct = Item(
                                      name: _editedProduct.name,
                                      price: _editedProduct.price,
                                      catId: _editedProduct.catId,
                                      imgUrl: value,
                                      isveg: _editedProduct.isveg,
                                      id: _editedProduct.id,
                                      isfav: _editedProduct.isfav,
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
