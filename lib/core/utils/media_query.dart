import 'package:flutter/widgets.dart';

class MQ {
  MQ._(); // private constructor

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double h(BuildContext context, double percent) =>
      height(context) * (percent / 100);

  static double w(BuildContext context, double percent) =>
      width(context) * (percent / 100);

  static EdgeInsets padding(BuildContext context) =>
      MediaQuery.of(context).padding;

  static double topPadding(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double bottomPadding(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;
}