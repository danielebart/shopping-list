import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'manage_shopping_list/add_item/add_shopping_item_widget.dart';
import 'manage_shopping_list/items/shopping_list_provider.dart';
import 'manage_shopping_list/items/shopping_list_widget.dart';

class HomeScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShoppingList', style: TextStyle(color: Colors.pink)),
        elevation: 0.0,
        backgroundColor: Colors.grey[50],
      ),
      body: Center(
        child: ShoppingListWidget(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('lista corrente')),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive), title: Text('Archivio'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => AddItemWidget()).then((value) {
              var provider = Provider.of<ShoppingListProvider>(context);
              if (value != null) provider.onItemAdded(value);
            })),
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
