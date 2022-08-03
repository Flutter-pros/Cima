import 'package:blur/blur.dart';
import 'package:cima/GetX/views/home_page_body.dart';
import 'package:cima/GetX/views/home_page_drawer.dart';
import 'package:flutter/material.dart';
//import other screens preparation for the bottom navigation bar
import 'package:cima/screens/movie_info.dart';
import 'package:cima/screens/content.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomePageBody(),
      MovienfoScreen(),
      const Content(),
    ];

    return Scaffold(
      drawer: const HomePageDrawer(),
      appBar: (_selectedPage != 1)
          ? AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: const Text('سيما'),
            )
          : null,
      body: Stack(children: [
        Blur(
          blur: 30,
          blurColor: const Color(0xff22202f).withOpacity(.1),
          child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/10.PNG"), fit: BoxFit.cover))),
        ),
        pages[_selectedPage]
      ]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent.withOpacity(.1),
        // backgroundColor: Theme.of(context).appBarTheme.backgroundColor!,
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'القائمة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'حول',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'مشاهدة وتحميل',
          ),
        ],
      ),
    );
  }

  // ListView drawerNestedListTile(AsyncSnapshot<dynamic> snapshot, int index) {
  //   return ListView.builder(
  //       itemCount: snapshot.data[index]["children"].length,
  //       itemBuilder: (context, index2) {
  //         return ListTile(
  //           title: Text("${snapshot.data[index]["children"][index2]["name"]}"),
  //         );
  //       });
  // }

}
