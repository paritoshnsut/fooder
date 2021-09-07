import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_app/DrawerPage.dart';
import 'package:rest_app/form-edit.dart';
import 'package:rest_app/product-item.dart';
import './models/items.dart';


class EditProduct extends StatelessWidget {

  static const routeName='/edit-product';
  @override
  Widget build(BuildContext context) {

    final productsData = Provider.of<Items>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(FormEdit.routeName);
            },
          ),
        ],
      ),
      drawer: DrawerPage(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                productsData.items[i].id,
                productsData.items[i].name,
                productsData.items[i].imgUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
