import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShoppingItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShoppingItemState();
}

class ShoppingItemState extends State<ShoppingItem> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text('Test'),
      controlAffinity: ListTileControlAffinity.leading,
      value: _isSelected,
      onChanged: (bool value) {
        setState(() => _isSelected = value);
      },
    );
  }
}
