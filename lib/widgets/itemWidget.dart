import 'package:flutter/material.dart';

import '../models/catalog.dart';


class ItemWidget extends StatelessWidget {
  final Item item;
  const ItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        elevation: 0,
        color: Colors.grey.shade100,
          child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            leading: Image.network(item.image,height: 90,width: 90,),
            title: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(item.name,style: TextStyle(color: Colors.grey.shade700,fontSize: 20)),
            ),
          ),
        ),
      ),
    );
  }
}
