import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:injector/injector.dart';
import 'package:shopping_list/shopping_list/manage_shopping_list/archive/archive_item_widget.dart';
import 'package:shopping_list/shopping_list/manage_shopping_list/archive/archive_provider.dart';
import 'package:shopping_list/shopping_list/manage_shopping_list/shopping_list.dart';

class ArchiveListWidget extends StatelessWidget {
  final archiveProvider = Injector.appInstance.getDependency<ArchiveProvider>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ShoppingList>>(
        stream: archiveProvider.shoppingLists,
        builder: (context, AsyncSnapshot<List<ShoppingList>> snapshot) {
          return StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            itemCount: snapshot.data?.length ?? 0,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            itemBuilder: (context, position) {
              return ArchiveItemWidget(snapshot.data[0]);
            },
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          );
        });
  }
}
