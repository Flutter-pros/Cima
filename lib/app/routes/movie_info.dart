import 'package:cima/app/routes/iconbuttonutils.dart';
import 'package:cima/app/routes/rowanddetails.dart';
import 'package:cima/app/routes/textutils.dart';
import 'package:flutter/material.dart';

class MovienfoScreen extends StatefulWidget {
  const MovienfoScreen({Key? key}) : super(key: key);

  @override
  State<MovienfoScreen> createState() => _MovienfoScreenState();
}

class _MovienfoScreenState extends State<MovienfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
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
                    child: IconButtonUtils(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onprassed: () {})),
                Positioned(
                  child: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.black,
                      child: IconButtonUtils(
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onprassed: () {})),
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
                      child: TextUtils(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        text: " 1h 20m  ",
                        textalign: TextAlign.end,
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
              child: Column(
                children: const [
                  DetailsRow(),
                  SizedBox(
                    height: 5,
                  ),
                  // DetailsRow(),
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
                children: [
                  TextUtils(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    text: "وصف الفيلم  ",
                    textalign: TextAlign.end,
                  ),
                  TextUtils(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    text:
                        "يتم اختيار فيوليت رودريغيز ، وهي مراهقة أمريكية مكسيكية يومية ، بواسطة قناع لوشادور السحري الذي يحولها إلى الترا فولت ، وهي بطل خارق يقاتل الجريمة إلى جانب عمها المتعصب ، كروز ، المعروف أيضًا باسم العقرب الأسود.",
                    textalign: TextAlign.end,
                  ),
                  TextUtils(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    text: "ذات صله ",
                    textalign: TextAlign.end,
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
                                  children: [
                                    TextUtils(
                                        text: "title",
                                        textalign: TextAlign.end,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)
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
