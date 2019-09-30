import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/shopping_list/manage_shopping_list/current_shopping_list/shopping_list_provider.dart';
import 'package:shopping_list/shopping_list/manage_shopping_list/shopping_list_item.dart';

class ShoppingItemWidget extends StatelessWidget {
  final ShoppingListItem item;

  ShoppingItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    final shoppingList =
    Provider.of<ShoppingListProvider>(context, listen: false);
    return _buildCheckbox(shoppingList);
  }

  Widget _buildCheckbox(ShoppingListProvider shoppingList) {
    return CheckboxListTile(
      title: item.flagged
          ? Text(item.title,
              style: TextStyle(decoration: TextDecoration.lineThrough))
          : Text(item.title),
      controlAffinity: ListTileControlAffinity.leading,
      value: item.flagged,
      onChanged: (bool value) {
        shoppingList.setFlagged(item.id, value);
      },
    );
  }
}
