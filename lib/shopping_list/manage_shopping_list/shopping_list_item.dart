import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

class ShoppingListItem {
  final String listId;
  final String id;
  final bool flagged;
  final String title;
  final int timestamp;

  ShoppingListItem({@required this.id,
    @required this.listId,
    @required this.flagged,
    @required this.timestamp,
    @required this.title});

  @override
  bool operator ==(o) =>
      o is ShoppingListItem &&
          flagged == o.flagged &&
          title == o.title &&
          id == o.id &&
          timestamp == o.timestamp &&
          listId == o.listId;

  @override
  int get hashCode =>
      hash4(id.hashCode, listId.hashCode, flagged.hashCode,
          hash2(title.hashCode, timestamp.hashCode));
}
