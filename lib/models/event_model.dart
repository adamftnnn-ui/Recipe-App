import 'package:flutter/material.dart';


class EventModel {
  final String title;
  final String subtitle;
  final String image;
  final int colorValue;

  EventModel({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.colorValue,
  });

  Color get color => Color(colorValue);
}
