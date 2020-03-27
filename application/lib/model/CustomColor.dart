import 'package:flutter/material.dart';

class CustomColor extends Color {
  CustomColor(String color) : super(int.parse(color.split('(0x')[1].split(')')[0], radix: 16));
}
