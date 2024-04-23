import 'package:flutter/material.dart';

import '../models/list_tile_model.dart';
class ListTileButton extends StatelessWidget {
  const ListTileButton({
    super.key,
    required this.listTileModel,
    required this.onTap,
  });
final ListTileModel listTileModel;
final Function onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap;
      },
      contentPadding: EdgeInsets.all(0),
      leading: Icon(
        listTileModel.leading,
        color: Colors.grey[800],
        size: 30,
      ),
      title: Text(
        listTileModel.title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey[800],
        ),
      ),
      trailing: Icon(
        listTileModel.trailing,
        color: Colors.grey[800],
        size: 15,
      ),
    );
  }
}