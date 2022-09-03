import 'package:cima/app/utils/textutils.dart';
import 'package:flutter/material.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.grey.withOpacity(.1),
          ),
          height: 40,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
        Container(
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.grey.withOpacity(.1),
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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.grey.withOpacity(.1),
          ),
          height: 40,
          width: 35,
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
    );
  }
}
