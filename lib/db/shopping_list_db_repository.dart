import "package:path/path.dart";
import "package:shopping_list/shopping_list_notifier.dart";
import 'package:shopping_list/shopping_list_repository.dart';
import "package:sqflite/sqflite.dart";

class ShoppingListDBRepository extends ShoppingListRepository {
  final Future<Database> database = _createDB();

  static Future<Database> _createDB() async {
    return openDatabase(
      join(await getDatabasesPath(), "shopping_list.db"),
      onCreate: (db, version) {
        db.execute("CREATE TABLE shopping_list_item("
            "item_id TEXT PRIMARY KEY, "
            "shopping_list_id TEXT, "
            "title TEXT, "
            "flagged INTEGER"
            ")");
      },
      version: 1,
    );
  }

  @override
  add(ShoppingListItem item) {
    _insertShoppingListItem(_ShoppingItem(
        itemId: item.id,
        shoppingListId: item.listId,
        flagged: item.flagged,
        title: item.title));
  }

  Future<void> _insertShoppingListItem(_ShoppingItem item) async {
    final Database db = await database;

    await db.insert(
      "shopping_list_item",
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  remove(String itemId) {
    _removeShoppingListItem(itemId);
  }

  Future<void> _removeShoppingListItem(String itemId) async {
    final Database db = await database;

    await db.delete(
      "shopping_list_item",
      where: "item_id = ?",
      whereArgs: [itemId],
    );
  }

  @override
  Future<List<ShoppingList>> getShoppingLists() async {
    final Database db = await database;

    final List<Map<String, dynamic>> dbEntries =
        await db.query("shopping_list_item");

    var entries = dbEntries.map((e) => _ShoppingItem.fromMap(e));

    return entries
        .map((e) => e.shoppingListId)
        .toSet()
        .map((listId) => createShoppingList(listId, entries))
        .toList();
  }

  @override
  Future<ShoppingList> getShoppingList(String id) async {
    final Database db = await database;

    final List<Map<String, dynamic>> dbEntries = await db.query(
        "shopping_list_item",
        where: "shopping_list_id = ?",
        whereArgs: [id]);

    var entries = dbEntries
        .map((e) => _ShoppingItem.fromMap(e))
        .map((_ShoppingItem e) => e.toUIModel())
        .toList();
    return ShoppingList(id, entries);
  }

  createShoppingList(id, entries) => ShoppingList(
      id,
      entries
          .where((item) => item.shoppingListId == id)
          .toList()
          .map((item) => item.toUIModel()));
}

class _ShoppingItem {
  final String itemId;
  final String shoppingListId;
  final bool flagged;
  final String title;

  _ShoppingItem({this.itemId, this.shoppingListId, this.flagged, this.title});

  Map<String, dynamic> toMap() => <String, dynamic>{
        "item_id": itemId,
        "shopping_list_id": shoppingListId,
        "flagged": flagged ? 1 : 0,
        "title": title,
      };

  ShoppingListItem toUIModel() => ShoppingListItem(
      id: itemId, listId: shoppingListId, flagged: flagged, title: title);

  factory _ShoppingItem.fromMap(Map<String, dynamic> map) => _ShoppingItem(
        itemId: map["item_id"],
        shoppingListId: map["shopping_list_id"],
        flagged: map["flagged"] == 0 ? false : true,
        title: map["title"],
      );
}
