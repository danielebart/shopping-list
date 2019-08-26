import 'package:injector/injector.dart';
import 'package:shopping_list/shopping_list/add_item/add_item_notifier.dart';
import 'package:shopping_list/shopping_list/db/shopping_list_db_repository.dart';
import 'package:shopping_list/shopping_list/items/shopping_list_notifier.dart';

// TODO refactor this component
registerCommonDependencies() {
  Injector injector = Injector.appInstance;

  injector.registerDependency<ShoppingListNotifier>((injector) {
    return ShoppingListNotifier(ShoppingListDBRepository());
  });

  injector.registerDependency<AddItemNotifier>((injector) {
    var currentListId = injector.getDependency<String>(
        dependencyName: "current_shopping_list_id");
    return AddItemNotifier(ShoppingListDBRepository(), currentListId);
  });

  injector.registerDependency<String>((injector) {
    var listNotifier = injector.getDependency<ShoppingListNotifier>();
    return listNotifier.currentListId;
  }, override: true, dependencyName: "current_shopping_list_id");
}
