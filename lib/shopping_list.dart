import 'package:flutter/widgets.dart';
import 'package:shopping_list/shopping_item.dart';

class ShoppingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, position) {
        return ShoppingItem();
      },
    );
  }
}
