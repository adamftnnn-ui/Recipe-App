import 'package:flutter/material.dart';
import '../models/event_model.dart';

class EventController {
  // Ganti List biasa jadi ValueNotifier<List<EventModel>>
  final ValueNotifier<List<EventModel>> events = ValueNotifier([
    EventModel(
      title: 'Spesial Ramadan',
      subtitle: 'Temukan inspirasi masakan buka puasa',
      image: 'assets/images/banner1.png',
      colorValue: 0xFFFFF8E1,
    ),
    EventModel(
      title: 'Menu Akhir Pekan',
      subtitle: 'Resep santai bareng keluarga di rumah',
      image: 'assets/images/banner2.png',
      colorValue: 0xFFE3F2FD,
    ),
    EventModel(
      title: 'Inspirasi Harian',
      subtitle: 'Coba resep baru setiap hari!',
      image: 'assets/images/banner3.png',
      colorValue: 0xFFF3E5F5,
    ),
  ]);

  // Kalau kamu mau fungsi ambil semua tetap ada:
  void fetchAllEvents() {
    events.value = events.value; // tetap trigger ValueListenableBuilder
  }
}
