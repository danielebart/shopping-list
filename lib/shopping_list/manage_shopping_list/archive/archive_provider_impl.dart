import 'package:flutter/cupertino.dart';
import 'package:shopping_list/shopping_list/manage_shopping_list/archive/archive_provider.dart';
import 'package:shopping_list/shopping_list/manage_shopping_list/current_shopping_list/shopping_list_repository.dart';
import 'package:shopping_list/shopping_list/manage_shopping_list/shopping_list.dart';

class ArchiveProviderImpl with ChangeNotifier implements ArchiveProvider {
  List<ShoppingList> _shoppingLists;
  final ShoppingListRepository _shoppingListRepository;

  ArchiveProviderImpl(this._shoppingListRepository);

  @override
  Stream<List<ShoppingList>> get shoppingLists {
    if (_shoppingLists == null) {
      return _shoppingListRepository.getShoppingLists().asStream().map((list) {
        _shoppingLists = list;
        return list;
      });
    } else {
      return Future.value(_shoppingLists).asStream();
    }
  }
}
