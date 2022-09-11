import 'package:cima/app/utils/textutils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

class DetailsRow extends StatelessWidget {
  const DetailsRow(
      {Key? key,
      required this.mediaRating,
      required this.mediaGenre,
      required this.mediaAging})
      : super(key: key);
  final String mediaRating;
  final String mediaGenre;
  final String mediaAging;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.2),
            blurRadius: 100,
            spreadRadius: 50,
            offset: const Offset(-10, 5)),
        BoxShadow(
            color: Colors.black.withOpacity(.5),
            blurRadius: 100,
            spreadRadius: 50,
            offset: const Offset(-10, 7)),
        BoxShadow(
            color: Colors.black.withOpacity(.5),
            blurRadius: 100,
            spreadRadius: 50,
            offset: const Offset(-10, 10)),
        BoxShadow(
            color: Colors.black.withOpacity(.8),
            blurRadius: 100,
            spreadRadius: 50,
            offset: const Offset(-10, 13)),
        BoxShadow(
            color: Colors.black.withOpacity(.8),
            blurRadius: 100,
            spreadRadius: 50,
            offset: const Offset(-2, 17))
      ]),
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              // color: Colors.grey.withOpacity(.1),
            ),
            height: 40,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextUtils(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    text: mediaRating,
                    textalign: TextAlign.end,
                  ),
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20,
                  )
                ]),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              // color: Colors.grey.withOpacity(.1),
            ),
            height: 40,
            child: Center(
              child: TextUtils(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                text: mediaGenre,
                textalign: TextAlign.end,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.grey.withOpacity(.1),
            ),
            child: Center(
              child: TextUtils(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                text: mediaAging,
                textalign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
