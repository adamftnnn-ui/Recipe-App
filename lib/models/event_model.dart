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

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      image: json['image'] ?? '',
      colorValue: json['colorValue'] ?? 0xFFFFF8E1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'image': image,
      'colorValue': colorValue,
    };
  }

  Color get color => Color(colorValue);
}
