import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/shopping_list/manage_shopping_list/shopping_list.dart';
import 'package:shopping_list/shopping_list/manage_shopping_list/shopping_list_item.dart';

class ArchiveItemWidget extends StatelessWidget {
  final ShoppingList shoppingList;

  ArchiveItemWidget(this.shoppingList);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
            children: shoppingList.items
                .map((s) => _mapShoppingItemToWidget(s))
                .toList()),
      ),
    );
  }

  Widget _mapShoppingItemToWidget(ShoppingListItem shoppingitem) {
    return _ArchiveShoppingItemWidget(shoppingitem);
  }
}

class _ArchiveShoppingItemWidget extends StatelessWidget {
  final ShoppingListItem shoppingListItem;

  _ArchiveShoppingItemWidget(this.shoppingListItem);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.done,
            size: 16,
            color: _generateRandomColor(),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            shoppingListItem.title,
            maxLines: 1,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Color _generateRandomColor() {
    return Colors
        .accents[shoppingListItem.hashCode % Colors.accents.length];
  }
}
