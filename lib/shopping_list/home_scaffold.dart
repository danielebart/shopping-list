import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'manage_shopping_list/add_item/add_shopping_item_widget.dart';
import 'manage_shopping_list/archive/archive_list_widget.dart';
import 'manage_shopping_list/items/shopping_list_provider.dart';
import 'manage_shopping_list/items/shopping_list_widget.dart';

class HomeScaffold extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScaffoldState();
  }
}

class _HomeScaffoldState extends State<HomeScaffold>
    with SingleTickerProviderStateMixin {
  var _currentIndex = 0;
  AnimationController _controller;
  Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this, value: 0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShoppingList', style: TextStyle(color: Colors.pink)),
        elevation: 0.0,
        backgroundColor: Colors.grey[50],
      ),
      body: _widgetFromSelectedIndex(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.list), title: Text('lista corrente')),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive), title: Text('Archivio'))
          ],
          onTap: (index) {
            setState(() => _currentIndex = index);
          }),
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          onPressed: (() =>
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => AddItemWidget()).then((value) {
                var provider = Provider.of<ShoppingListProvider>(context);
                if (value != null) provider.onItemAdded(value);
              })),
          child: Icon(Icons.add_shopping_cart),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _widgetFromSelectedIndex() {
    switch (_currentIndex) {
      case 0:
        _controller.forward();
        return ShoppingListWidget();
      case 1:
        _controller.reverse();
        return ArchiveListWidget();
    }
  }
}
