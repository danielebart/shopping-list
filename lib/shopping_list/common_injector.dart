import 'package:injector/injector.dart';
import 'package:shopping_list/shopping_list/manage_shopping_list/archive/archive_provider.dart';
import 'package:shopping_list/shopping_list/manage_shopping_list/archive/archive_provider_impl.dart';

import 'manage_shopping_list/add_item/add_item_provider.dart';
import 'manage_shopping_list/add_item/add_item_provider_impl.dart';
import 'manage_shopping_list/current_shopping_list/shopping_list_provider.dart';
import 'manage_shopping_list/current_shopping_list/shopping_list_provider_impl.dart';
import 'manage_shopping_list/current_shopping_list/shopping_list_repository.dart';
import 'manage_shopping_list/db/shopping_list_db_repository.dart';

// TODO refactor this component
registerCommonDependencies() {
  Injector injector = Injector.appInstance;

  injector.registerDependency<ShoppingListRepository>((injector) {
    return ShoppingListDBRepository();
  });

  injector.registerSingleton<ShoppingListProvider>((injector) {
    var shoppingListRepository =
    injector.getDependency<ShoppingListRepository>();
    return ShoppingListProviderImpl(shoppingListRepository);
  });

  injector.registerDependency<AddItemProvider>((injector) {
    var currentListId = injector.getDependency<String>(
        dependencyName: CURRENT_SHOPPING_LIST_ID);
    var shoppingListRepository =
    injector.getDependency<ShoppingListRepository>();
    return AddItemProviderImpl(shoppingListRepository, currentListId);
  });

  injector.registerDependency<ArchiveProvider>((injector) {
    var shoppingListRepository =
    injector.getDependency<ShoppingListRepository>();
    return ArchiveProviderImpl(shoppingListRepository);
  });

  injector.registerDependency<String>((injector) {
    var listNotifier = injector.getDependency<ShoppingListProvider>();
    return listNotifier.currentListId;
  }, override: true, dependencyName: CURRENT_SHOPPING_LIST_ID);
}

const CURRENT_SHOPPING_LIST_ID = "current_shopping_list_id";