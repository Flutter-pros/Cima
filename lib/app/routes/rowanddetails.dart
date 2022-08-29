import 'package:cima/app/routes/iconbuttonutils.dart';
import 'package:cima/app/routes/textutils.dart';
import 'package:flutter/material.dart';

class DetailsRow extends StatelessWidget {
  const DetailsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                child: IconButtonUtils(
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    onprassed: () {}))),
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
                TextUtils(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  text: "5.0",
                  textalign: TextAlign.end,
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
            child: TextUtils(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              text: "جريمه",
              textalign: TextAlign.end,
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
            child: TextUtils(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              text: "+18",
              textalign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }
}
