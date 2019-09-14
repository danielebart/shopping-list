import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MaterialTestProvider<T extends ChangeNotifier> extends StatelessWidget {
  final Widget child;
  final T provider;

  MaterialTestProvider({this.child, this.provider});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ChangeNotifierProvider<T>(
          builder: (context) => provider,
          child: child,
        ),
      ),
    );
  }
}
