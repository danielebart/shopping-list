import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../shopping_list_item.dart';
import '../shopping_list_repository.dart';

class AddItemNotifier with ChangeNotifier {
  final ShoppingListRepository _shoppingListRepository;
  final String _currentListID;
  AddItemState _state = AddItemDisabled();
  String _currentText = "";

  AddItemNotifier(this._shoppingListRepository, this._currentListID);

  AddItemState get state => _state;

  addButtonPressed() {
    assert(_currentText.isNotEmpty);

    var uuid = new Uuid();
    var item = ShoppingListItem(
        id: uuid.v4(),
        listId: _currentListID,
        title: _currentText,
        flagged: false);
    _shoppingListRepository.add(item);
    _state = AddItemSuccess(item);
    notifyListeners();
  }

  onTextChanged(String text) {
    _currentText = text;
    var previousState = _state;
    _state = text.trim().isEmpty ? AddItemDisabled() : AddItemEnabled();
    if (previousState != _state) notifyListeners();
  }

  setIdle() {
    _state = Idle();
  }
}

abstract class AddItemState {}

class Idle extends AddItemState {}

class AddItemDisabled extends AddItemState {}

class AddItemEnabled extends AddItemState {}

class AddItemSuccess extends AddItemState {
  final ShoppingListItem item;

  AddItemSuccess(this.item);
}
