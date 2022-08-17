import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle basicTextStyle = TextStyle(
        fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white);
    return Center(
        child: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        children: const <ListTile>[
          ListTile(
            leading: Icon(Icons.play_arrow, color: Colors.white),
            title: Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Center(child: Text('حلقة 1', style: basicTextStyle)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.play_arrow, color: Colors.white),
            title: Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Center(child: Text('حلقة 2', style: basicTextStyle)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.play_arrow, color: Colors.white),
            title: Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Center(child: Text('حلقة 3', style: basicTextStyle)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.play_arrow, color: Colors.white),
            title: Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Center(child: Text('حلقة 4', style: basicTextStyle)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.play_arrow, color: Colors.white),
            title: Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Center(child: Text('حلقة 5', style: basicTextStyle)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.play_arrow, color: Colors.white),
            title: Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Center(child: Text('حلقة 6', style: basicTextStyle)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.play_arrow, color: Colors.white),
            title: Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Center(child: Text('حلقة 7', style: basicTextStyle)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.play_arrow, color: Colors.white),
            title: Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Center(child: Text('حلقة 8', style: basicTextStyle)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.play_arrow, color: Colors.white),
            title: Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Center(child: Text('حلقة 9', style: basicTextStyle)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.play_arrow, color: Colors.white),
            title: Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Center(child: Text('حلقة 10', style: basicTextStyle)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.play_arrow, color: Colors.white),
            title: Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Center(child: Text('حلقة 11', style: basicTextStyle)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.play_arrow, color: Colors.white),
            title: Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Center(child: Text('حلقة 12', style: basicTextStyle)),
            ),
          )
        ],
      ),
    ));
  }
}
