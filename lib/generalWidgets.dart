
import 'package:flutter/material.dart';

class GenericContainer extends StatelessWidget {
  final Widget child;
  const GenericContainer({Key key, this.child}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all( 8),
    decoration: BoxDecoration(
    color: Theme.of(context).cardColor, //.withOpacity(0.65),
    borderRadius: BorderRadius.circular(10),
    ),
        child: child,
      ),
    );
  }
}
