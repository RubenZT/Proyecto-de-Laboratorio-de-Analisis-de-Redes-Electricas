import 'package:flutter/material.dart';

class AppICon extends StatelessWidget {
  final double size;
  final EdgeInsets margin;
  const AppICon({Key? key, this.size = 64, this.margin = const EdgeInsets.all(8)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: SizedBox.square(
          dimension: size,
          child: Image.asset('assets/icon.jpg'),
        ),
      ),
    );
  }
}
