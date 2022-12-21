import 'package:flutter/material.dart';
import 'package:flutterappclue/models/catalog.dart';
import 'package:flutterappclue/widgets/itemWidget.dart';


class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Hilfe"),
      ),
      body:ListView.builder(
        itemCount: CatalogModel.items.length,
        itemBuilder: (context,index){
          return ItemWidget(item: CatalogModel.items[index]);
        },
      ),
    );
  }
}
