import 'package:flutter/material.dart';

class MovieInfoScreen extends StatefulWidget {
  const MovieInfoScreen({Key? key}) : super(key: key);

  @override
  State<MovieInfoScreen> createState() => _MovieInfoScreenState();
}

class _MovieInfoScreenState extends State<MovieInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0c0f21),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
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
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ))),
                Positioned(
                  child: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.black,
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.play_arrow)),
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
                    child: const Center(
                      child: Text(
                        style: TextStyle(color: Colors.black),
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
            const SizedBox(
              height: 10,
            ),
            SizedBox(
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
                            icon: const Icon(Icons.share)),
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
                        children: const [
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
                    child: const Center(
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
                    child: const Center(
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
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
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
              child: Container(
                decoration: const BoxDecoration(),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    // Blur(
                    //   blur: 200,
                    //   blurColor: const Color(0xff22202f).withOpacity(.1),
                    //   child: Container(
                    //       decoration: const BoxDecoration(
                    //           image: DecorationImage(
                    //               image: AssetImage("images/10.PNG"),
                    //               fit: BoxFit.cover))),
                    // ),
                    ListView.builder(
                        itemCount: 17,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          return Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(30),
                            )),
                            color: const Color(0xff23273b),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 170,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      fit: BoxFit.fill,
                                      "https://mycima.fun/wp-content/uploads/2022/06/%D9%85%D8%B3%D9%84%D8%B3%D9%84-In-the-Dark-%D8%A7%D9%84%D9%85%D9%88%D8%B3%D9%85-%D8%A7%D9%84%D8%B1%D8%A7%D8%A8%D8%B9-347x520.jpg",
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Image.asset(
                                            "images/failLoading/image_fail_loading.jpeg");
                                      },
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [
                                    Text(
                                      "title",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}







//  SizedBox(
//               height: 250,
//               width: MediaQuery.of(context).size.width / 1,
//               child: Stack(children: [
//                 ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: ((context, index) {
//                     return Card(
//                       shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(25),
//                         topRight: Radius.circular(30),
//                       )),
//                       color: Color(0xff23273b),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             height: 190,
//                             width: MediaQuery.of(context).size.width / 3,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.network(
//                                 fit: BoxFit.fill,
//                                 "https://mycima.fun/wp-content/uploads/2022/06/%D9%85%D8%B3%D9%84%D8%B3%D9%84-In-the-Dark-%D8%A7%D9%84%D9%85%D9%88%D8%B3%D9%85-%D8%A7%D9%84%D8%B1%D8%A7%D8%A8%D8%B9-347x520.jpg",
//                                 errorBuilder: (BuildContext context,
//                                     Object exception, StackTrace? stackTrace) {
//                                   return Image.asset(
//                                       "images/failLoading/image_fail_loading.jpeg");
//                                 },
//                               ),
//                             ),
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 "a",
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     );
//                   }),
//                   itemCount: 15,
//                 ),
//               ]),
//             ),