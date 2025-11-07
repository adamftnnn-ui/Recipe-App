import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // Hanya untuk Colors/ColorValue
import 'package:flutter_application_1/controllers/api_services.dart'; // Sesuaikan path
import '../models/event_model.dart'; // Pastikan EventModel diimpor

class EventController {
  // ValueNotifier untuk menyimpan dan mengelola daftar EventModel yang diambil secara dinamis.
  final ValueNotifier<List<EventModel>> events = ValueNotifier([]);

  // Properti dinamis (non-static) untuk koneksi API.
  final ApiService apiService;

  // Constructor menerima ApiService
  EventController(this.apiService);

  // Getter yang mengembalikan nilai dari ValueNotifier
  List<EventModel> getAllEvents() => events.value;

  // Daftar warna acak untuk simulasi banner event
  final List<int> _colorValues = const [
    0xFFFFF8E1, // Kuning Muda
    0xFFE3F2FD, // Biru Muda
    0xFFF3E5F5, // Ungu Muda
    0xFFFFEBF2, // Pink Muda
    0xFFE8F5E9, // Hijau Muda
  ];

  // Metode untuk mengambil data event (simulasi dari API resep)
  Future<void> fetchAllEvents() async {
    events.value = []; // Bersihkan event saat mulai fetching

    try {
      // Menggunakan endpoint /recipes/random untuk mendapatkan 3 "event" simulasi
      final endpoint = "recipes/random?number=3";

      final result = await ApiService.getData(endpoint);

      if (result != null && result.containsKey('recipes')) {
        final List<dynamic> rawRecipes = result['recipes'];

        // --- PROSES MAPPING DATA ---
        final List<EventModel> eventList = rawRecipes.asMap().entries.map((
          entry,
        ) {
          final index = entry.key;
          final item = entry.value;

          // Ambil judul/tag yang relevan untuk dijadikan Event Banner
          String title = item['title'] ?? 'Resep Baru';
          String subtitle =
              'Waktu masak: ${item['readyInMinutes'] ?? '30'} menit';

          // Ambil warna secara bergantian dari daftar _colorValues
          final colorValue = _colorValues[index % _colorValues.length];

          return EventModel(
            title: title
                .split(' ')
                .take(3)
                .join(' '), // Ambil 3 kata pertama judul
            subtitle: subtitle,
            image:
                item['image'] ??
                'assets/images/placeholder.png', // Menggunakan image API
            colorValue: colorValue,
          );
        }).toList();

        // Update ValueNotifier
        events.value = eventList;
      }
    } catch (e) {
      print("Error fetching events: $e");
      events.value = []; // Jika error, daftar event kosong
    }
  }
}
