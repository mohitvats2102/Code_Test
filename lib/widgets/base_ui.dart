import 'package:flutter/material.dart';

import '../constant.dart';

class BaseUI extends StatelessWidget {
  final EdgeInsets padding;
  final String text1, text2;
  final double height;
  final FontWeight fontWeight1, fontWeight2;
  final double fontsize1;
  final double fontsize2;
  final Widget child;
  final BorderRadius radius;

  BaseUI(
      {required this.fontWeight1,
      required this.padding,
      this.text2 = '',
      this.text1 = '',
      required this.height,
      required this.child,
      required this.fontsize1,
      required this.fontsize2,
      required this.radius,
      required this.fontWeight2});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: kloginText.copyWith(
                    fontSize: fontsize1, fontWeight: fontWeight2),
              ),
              Text(
                text2,
                style: kloginText.copyWith(
                  fontSize: fontsize2,
                  fontWeight: fontWeight1,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height),
        Expanded(
          child: Container(
            decoration: kloginContainerDecoration.copyWith(
              borderRadius: radius,
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
