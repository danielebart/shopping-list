import 'package:shopping_list/shopping_list_notifier.dart';

abstract class ShoppingListRepository {
  Future<List<ShoppingList>> getShoppingLists();

  Future<ShoppingList> getShoppingList(String id);

  add(ShoppingListItem item);

  remove(String itemId);
}
