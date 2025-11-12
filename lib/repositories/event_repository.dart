import '../models/event_model.dart';
import '../services/api_service.dart';

class EventRepository {
  Future<List<EventModel>> fetchEvents() async {
    final List<Map<String, dynamic>> queries = [
      {
        'title': 'Spesial Ramadan',
        'subtitlePrefix': 'Koleksi masakan khas Middle Eastern',
        'query': 'middle eastern',
        'colorValue': 0xFFFFF8E1,
      },
      {
        'title': 'Menu Akhir Pekan',
        'subtitlePrefix': 'Comfort food untuk santai akhir pekan',
        'query': 'comfort food',
        'colorValue': 0xFFE3F2FD,
      },
      {
        'title': 'Inspirasi Harian',
        'subtitlePrefix': 'Pilihan resep sehat setiap hari',
        'query': 'healthy',
        'colorValue': 0xFFF3E5F5,
      },
    ];

    final List<EventModel> events = [];
    for (final q in queries) {
      final endpoint =
          "recipes/complexSearch?query=${Uri.encodeQueryComponent(q['query'])}&number=3&addRecipeInformation=true";
      final resp = await ApiService.getData(endpoint);
      if (resp != null &&
          resp['results'] is List &&
          (resp['results'] as List).isNotEmpty) {
        final hits = resp['results'] as List;
        final first = hits.first;
        events.add(
          EventModel(
            title: q['title'],
            subtitle: (first['title'] ?? q['subtitlePrefix']).toString(),
            image: first['image'] ?? '',
            colorValue: q['colorValue'],
          ),
        );
      } else {
        events.add(
          EventModel(
            title: q['title'],
            subtitle: q['subtitlePrefix'],
            image: '',
            colorValue: q['colorValue'],
          ),
        );
      }
    }
    return events;
  }
}
