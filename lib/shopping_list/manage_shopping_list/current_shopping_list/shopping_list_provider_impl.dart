import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shopping_list/shopping_list/manage_shopping_list/current_shopping_list/shopping_list_provider.dart';

import '../shopping_list.dart';
import '../shopping_list_item.dart';
import 'shopping_list_repository.dart';

class ShoppingListProviderImpl
    with ChangeNotifier
    implements ShoppingListProvider {
  String _currentListId;
  final ShoppingListRepository
  _shoppingListRepository; // TODO move it in a interactor
  ShoppingList _inMemoryShoppingList; // TODO move it in a interactor
  var shoppingListRepositoryStreamSubscription;

  ShoppingListProviderImpl(this._shoppingListRepository) {
    shoppingListRepositoryStreamSubscription = _shoppingListRepository
        .getShoppingLists()
        .asStream()
        .handleError((e, stacktrace) => print("$e\n$stacktrace"))
        .listen((shoppingLists) => _onShoppingListResult(shoppingLists));
  }

  _onShoppingListResult(List<ShoppingList> lists) {
    List<int> timestamps = lists
        .expand<ShoppingListItem>((i) => i.items)
        .map((ShoppingListItem item) => item.timestamp)
        .toList()
      ..sort();

    _currentListId = lists
        .expand<ShoppingListItem>((i) => i.items)
        .singleWhere((item) => item.timestamp == timestamps.last,
        orElse: () => null)
        ?.listId ??
        _currentTimestamp().toString();
    _inMemoryShoppingList = lists.singleWhere(
            (ShoppingList list) => list.id == currentListId,
        orElse: () => ShoppingList(currentListId, []));
  }

  @override
  String get currentListId => _currentListId;

  @override
  Stream<ShoppingList> get list {
    return Stream.fromFuture(Future.value(_inMemoryShoppingList));
  }

  @override
  onItemAdded(ShoppingListItem item) {
    if (_inMemoryShoppingList == null) {
      _inMemoryShoppingList = ShoppingList(currentListId, []);
    }
    _inMemoryShoppingList.items.add(item);
    notifyListeners();
  }

  @override
  removeItem(String id) {
    _inMemoryShoppingList.items?.removeWhere((item) => item.id == id);
    _shoppingListRepository.remove(id);

    if (_inMemoryShoppingList.items.every((item) => item.flagged)) {
      _createNewShoppingList();
    }

    notifyListeners();
  }

  @override
  setFlagged(String id, bool flagged) {
    final oldItem = findByID(id);
    final listItemIndex = _inMemoryShoppingList.items.indexOf(oldItem);
    final newItem = ShoppingListItem(
        id: id,
        listId: oldItem.listId,
        timestamp: _currentTimestamp(),
        title: oldItem.title,
        flagged: flagged);

    _inMemoryShoppingList.items[listItemIndex] = newItem;
    _shoppingListRepository.add(newItem);

    if (_inMemoryShoppingList.items.every((item) => item.flagged)) {
      _createNewShoppingList();
    }

    notifyListeners();
  }

  _createNewShoppingList() {
    _inMemoryShoppingList = ShoppingList(currentListId, []);
    _currentListId = _currentTimestamp()
        .toString(); // TODO move this stuff in the interactor
  }

  @override
  ShoppingListItem findByID(final String id) => _inMemoryShoppingList.items
      .firstWhere((ShoppingListItem item) => item.id == id);

  @override
  void dispose() {
    shoppingListRepositoryStreamSubscription.cancel();
    super.dispose();
  }

  _currentTimestamp() {
    return DateTime
        .now()
        .millisecondsSinceEpoch;
  }
}
