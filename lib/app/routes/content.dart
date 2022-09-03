import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);
  final TextStyle basicTextStyle = const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black);
  ListTile getListViewBodyElements(int index, Color color) {
    return ListTile(
        leading: Icon(Icons.play_arrow, color: color),
        title: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Center(child: Text('حلقة $index', style: basicTextStyle)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return getListViewBodyElements(index, Colors.white);
          }),
    );
  }
}
