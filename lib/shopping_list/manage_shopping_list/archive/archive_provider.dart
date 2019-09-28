import 'package:flutter/foundation.dart';
import 'package:shopping_list/shopping_list/manage_shopping_list/shopping_list.dart';

abstract class ArchiveProvider implements ChangeNotifier {
  Stream<List<ShoppingList>> get shoppingLists;
}
