import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/shopping_item_widget.dart';
import 'package:shopping_list/shopping_list.dart';

class ShoppingListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => ShoppingList(),
      child: _buildListView(context),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Consumer<ShoppingList>(
        builder: (context, shoppingList, _) => ListView.builder(
            itemCount: shoppingList.listItems.length,
            itemBuilder: (context, position) =>
                ShoppingItemWidget(shoppingList.listItems[position].id)));
  }
}
