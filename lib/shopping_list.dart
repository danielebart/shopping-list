import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

class ShoppingList with ChangeNotifier {
  // TODO fake list, to be replaced with a repository
  List<ShoppingListItem> _listItems = [
    ShoppingListItem("1", true, "test1"),
    ShoppingListItem("2", false, "test2"),
    ShoppingListItem("3", false, "test3"),
    ShoppingListItem("4", false, "test4"),
    ShoppingListItem("6", false, "test5"),
    ShoppingListItem("7", false, "test6"),
    ShoppingListItem("8", false, "test7"),
    ShoppingListItem("9", false, "test8"),
    ShoppingListItem("10", false, "test9"),
    ShoppingListItem("11", false, "testA"),
    ShoppingListItem("12", false, "testB"),
    ShoppingListItem("13", false, "testC"),
    ShoppingListItem("14", false, "testD"),
    ShoppingListItem("21", false, "testE"),
    ShoppingListItem("22", false, "testF"),
    ShoppingListItem("23", false, "testG"),
    ShoppingListItem("31", false, "testH"),
    ShoppingListItem("32", false, "testI"),
    ShoppingListItem("33", false, "testJ"),
    ShoppingListItem("34", false, "testK"),
    ShoppingListItem("45", false, "testL"),
    ShoppingListItem("67", false, "testM"),
  ];

  UnmodifiableListView<ShoppingListItem> get listItems =>
      UnmodifiableListView(_listItems);

  setFlagged(String id, bool flagged) {
    final item = findByID(id);
    final listItemIndex = _listItems.indexOf(item);
    _listItems[listItemIndex] = ShoppingListItem(id, flagged, item.title);
    notifyListeners();
  }

  ShoppingListItem findByID(final String id) =>
      _listItems.firstWhere((ShoppingListItem item) => item.id == id);
}

class ShoppingListItem {
  final String id;
  final bool flagged;
  final String title;

  ShoppingListItem(this.id, this.flagged, this.title);

  @override
  bool operator ==(o) =>
      o is ShoppingListItem && flagged == o.flagged && title == o.title;

  @override
  int get hashCode => hash2(flagged.hashCode, title.hashCode);
}
