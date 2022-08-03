import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class MovienfoScreen extends StatefulWidget {
  MovienfoScreen({Key? key}) : super(key: key);

  @override
  State<MovienfoScreen> createState() => _MovienfoScreenState();
}

class _MovienfoScreenState extends State<MovienfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  // decoration: BoxDecoration(boxShadow: [
                  //   BoxShadow(
                  //       color: Colors.black,
                  //       spreadRadius: 1,
                  //       offset: Offset(-10, -5),
                  //       blurRadius: 10,
                  //       blurStyle: BlurStyle.normal)
                  // ]),
                  height: 250,
                  width: MediaQuery.of(context).size.width / 1,
                  child: Image.network(
                    "https://mycima.fun/wp-content/uploads/2022/06/%D9%85%D8%B3%D9%84%D8%B3%D9%84-In-the-Dark-%D8%A7%D9%84%D9%85%D9%88%D8%B3%D9%85-%D8%A7%D9%84%D8%B1%D8%A7%D8%A8%D8%B9-347x520.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                    right: 2,
                    top: 5,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ))),
                Positioned(
                  child: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.black,
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.play_arrow)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      // color: Colors.grey.withOpacity(.1),
                    ),
                    height: 40,
                    width: 80,
                    child: Center(
                      child: Text(
                        style: TextStyle(color: Colors.white),
                        " 1h 20m  ",
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.black.withOpacity(.1),
                    ),
                    height: 30,
                    width: MediaQuery.of(context).size.width / 1,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.withOpacity(.1),
                      ),
                      height: 40,
                      child: Center(
                        child: IconButton(
                            color: Colors.white,
                            onPressed: () {},
                            icon: Icon(Icons.share)),
                      )),
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey.withOpacity(.1),
                    ),
                    height: 40,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "5.0",
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20,
                          )
                        ]),
                  ),
                  Container(
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey.withOpacity(.1),
                    ),
                    height: 40,
                    child: Center(
                      child: Text(
                        "جريمه",
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey.withOpacity(.1),
                    ),
                    height: 40,
                    width: 35,
                    child: Center(
                      child: Text(
                        "+18",
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "وصف الفيلم  :",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "يتم اختيار فيوليت رودريغيز ، وهي مراهقة أمريكية مكسيكية يومية ، بواسطة قناع لوشادور السحري الذي يحولها إلى الترا فولت ، وهي بطل خارق يقاتل الجريمة إلى جانب عمها المتعصب ، كروز ، المعروف أيضًا باسم العقرب الأسود.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "ذات صله     :",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return Container(
                    height: 250,
                    width: 200,
                    child: Image.network(
                        "https://static.remove.bg/remove-bg-web/bf3af3e882eb04971b4492a1015ef7e77df29362/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png"),
                  );
                }),
                itemCount: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
