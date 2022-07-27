import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class ScreenFilms extends StatelessWidget {
  const ScreenFilms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Blur(
        blur: 30,
        blurColor: const Color(0xff22202f).withOpacity(.1),
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/10.PNG"), fit: BoxFit.cover))),
      ),
      Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                              image: AssetImage("images/10.PNG"),
                              fit: BoxFit.fill)))
                ],
              ),
              SizedBox(
                height: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      InkWell(
                        child: Text(
                          "ماي سيمـا",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffc2cafe)),
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                          child: Text(
                        "مسلسلات",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffc2cafe)),
                      )),
                      SizedBox(width: 20),
                      InkWell(
                        child: Text(
                          "مسلسلات اجنبي",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffc2cafe)),
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        child: Text(
                          "Safe",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffc2cafe)),
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        child: Text(
                          "موسم1",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffc2cafe)),
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "مشاهدة مسلسل Safe موسم 1 حلقه 8 والأخيرة",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffffffff)),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(children: const [
                  Expanded(
                      child: Text(
                    "مشاهدة مسلسل Safe موسم 1 حلقة 8 والأخيرة (2018)",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffffffff)),
                  ))
                ]),
              ),
              const Divider(
                color: Color(0xffc2cafe),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "الاسـم بالعربي",
                      style: TextStyle(color: Color(0xffc2cafe), fontSize: 15),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "اَمن",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "التصنيف",
                      style: TextStyle(color: Color(0xffc2cafe), fontSize: 15),
                    ),
                    SizedBox(width: 55),
                    Text(
                      "يحتوي علي مشاهد فاضحة",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "المسلسل",
                      style: TextStyle(color: Color(0xffc2cafe), fontSize: 15),
                    ),
                    SizedBox(width: 57),
                    Text(
                      "Safe",
                      style: TextStyle(
                        color: Color(0xffc2cafe),
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "المدة",
                      style: TextStyle(color: Color(0xffc2cafe), fontSize: 15),
                    ),
                    SizedBox(width: 81),
                    Text(
                      "356 دقيقة",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "النوع",
                      style: TextStyle(color: Color(0xffc2cafe), fontSize: 15),
                    ),
                    SizedBox(width: 80),
                    Text(
                      "جريمة,دراما,غموض,إثارة",
                      style: TextStyle(
                        color: Color(0xffc2cafe),
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "الجودة",
                      style: TextStyle(color: Color(0xffc2cafe), fontSize: 15),
                    ),
                    SizedBox(width: 70),
                    Text(
                      "webReb 720p",
                      style: TextStyle(
                        color: Color(0xffc2cafe),
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "شركات الإنتاج",
                      style: TextStyle(color: Color(0xffc2cafe), fontSize: 15),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "canal+",
                      style: TextStyle(
                        color: Color(0xffc2cafe),
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "معروف أيضاً ب",
                      style: TextStyle(color: Color(0xffc2cafe), fontSize: 15),
                    ),
                    SizedBox(width: 13),
                    Text(
                      "hong kong",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "مشاركـة",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff209b54),
                        borderRadius: BorderRadius.circular(8)),
                    height: 40,
                    width: 60,
                    child: Center(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.whatsapp,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff0772c0),
                        borderRadius: BorderRadius.circular(8)),
                    height: 40,
                    width: 60,
                    child: Center(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.messenger,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff175bb7),
                        borderRadius: BorderRadius.circular(8)),
                    height: 40,
                    width: 60,
                    child: Center(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.facebook,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff2277a8),
                        borderRadius: BorderRadius.circular(8)),
                    height: 40,
                    width: 60,
                    child: Center(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.telegram,
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff15192a).withOpacity(1),
                      boxShadow: const [BoxShadow(blurRadius: 20)]),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.yard_outlined,
                              size: 20,
                              color: Color(0xff5367ff),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "قصة العرض",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: const Text(
                          "بعد أن باتت ابنته المُراهقة في عداد المفقودين، يبدأ جرّاح أرمل يسكن في حي راقٍ في كشف أسرار غامضة عن الأشخاص المقربين منه.",
                          style: TextStyle(
                              color: Color(0xffc2cafe),
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black.withOpacity(.8),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "تابعنا على مواقع التواصل الإجتماعي",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xff175bb7),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    height: 40,
                                    width: 50,
                                    child: Center(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.facebook,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xff2277a8),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    height: 40,
                                    width: 50,
                                    child: Center(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.telegram,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ]),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          )
        ]),
      )
    ]));
  }
}
