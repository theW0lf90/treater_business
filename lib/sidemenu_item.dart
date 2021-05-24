

import 'package:flutter/material.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({Key key,
    this.isActive, this.isHover, this.showBorder, this.ItemCOunt, this.title, this.VoidCallback, this.press}) : super(key: key);
  final bool isActive, isHover, showBorder;
  final int ItemCOunt;
  final String title;
  final VoidCallback ,press;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
