import 'package:flutter/foundation.dart';
import '../controllers/api_services.dart';
import '../models/event_model.dart';

class EventController {
  final ValueNotifier<List<EventModel>> events =
      ValueNotifier<List<EventModel>>([]);

  Future<void> fetchEventsFromSpoonacular() async {
    final List<_EventQuery> queries = [
      _EventQuery(
        title: 'Spesial Ramadan',
        subtitlePrefix: 'Koleksi masakan khas Middle Eastern',
        query: 'middle eastern',
        colorValue: 0xFFFFF8E1,
      ),
      _EventQuery(
        title: 'Menu Akhir Pekan',
        subtitlePrefix: 'Comfort food untuk santai akhir pekan',
        query: 'comfort food',
        colorValue: 0xFFE3F2FD,
      ),
      _EventQuery(
        title: 'Inspirasi Harian',
        subtitlePrefix: 'Pilihan resep sehat setiap hari',
        query: 'healthy',
        colorValue: 0xFFF3E5F5,
      ),
    ];

    final List<EventModel> resultEvents = [];

    for (final q in queries) {
      try {
        final endpoint =
            "recipes/complexSearch?query=${Uri.encodeQueryComponent(q.query)}&number=3&addRecipeInformation=true";
        final resp = await ApiService.getData(endpoint);

        if (resp != null &&
            resp['results'] is List &&
            (resp['results'] as List).isNotEmpty) {
          final List<dynamic> hits = resp['results'] as List<dynamic>;

          // Pick first recipe as representative; subtitle uses first recipe title (shortened)
          final first = hits.first;
          final title = q.title;
          final subtitle = (first['title'] ?? q.subtitlePrefix).toString();
          final image = first['image'] ?? '';
          final colorValue = q.colorValue;

          resultEvents.add(
            EventModel(
              title: title,
              subtitle: subtitle,
              image: image,
              colorValue: colorValue,
            ),
          );
        } else {
          // fallback item (kehilangan data) — tetap tambahkan satu event agar UI konsisten
          resultEvents.add(
            EventModel(
              title: q.title,
              subtitle: q.subtitlePrefix,
              image: '',
              colorValue: q.colorValue,
            ),
          );
        }
      } catch (e) {
        // jika error, tambahkan fallback (tanpa menghentikan loop)
        resultEvents.add(
          EventModel(
            title: q.title,
            subtitle: q.subtitlePrefix,
            image: '',
            colorValue: q.colorValue,
          ),
        );
      }
    }

    events.value = resultEvents;
  }
}

class _EventQuery {
  final String title;
  final String subtitlePrefix;
  final String query;
  final int colorValue;
  _EventQuery({
    required this.title,
    required this.subtitlePrefix,
    required this.query,
    required this.colorValue,
  });
}
