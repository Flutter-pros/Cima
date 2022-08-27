import 'package:flutter/material.dart';

class IconButtonUtils extends StatelessWidget {
  IconButtonUtils({Key? key, required this.icon, required this.onprassed})
      : super(key: key);
  final Widget icon;
  final Function onprassed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: icon,
    );
  }
}
