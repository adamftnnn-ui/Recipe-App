import 'package:flutter/foundation.dart';
import 'dart:math';
import '../controllers/api_services.dart';

class RecipeListController {
  final ValueNotifier<List<String>> suggestions = ValueNotifier([]);
  final ValueNotifier<List<dynamic>> recipes = ValueNotifier([]);

  Future<void> fetchSuggestionsFromApi() async {
    try {
      final result = await ApiService.getData("recipes/random?number=6");
      if (result != null && result.containsKey('recipes')) {
        final List<String> newSuggestions = (result['recipes'] as List)
            .map((item) => item['title']?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList();
        suggestions.value = newSuggestions;
      }
    } catch (_) {}
  }

  Future<void> fetchRecipesByFilter(String filter) async {
    recipes.value = [];
    try {
      if (filter.isEmpty) return;
      final q = Uri.encodeQueryComponent(filter);
      final result = await ApiService.getData(
        "recipes/complexSearch?query=$q&number=20&addRecipeInformation=true&includeNutrition=true",
      );
      if (result != null && result.containsKey('results')) {
        final mapped = (result['results'] as List).map((item) {
          final cuisines = item['cuisines'];
          String country = 'Global';
          if (cuisines is List && cuisines.isNotEmpty)
            country = cuisines[0].toString();
          final isHalal =
              !(item['vegetarian'] == true || item['vegan'] == true);
          return {
            'id': item['id'],
            'title': item['title'] ?? 'Tanpa Judul',
            'image': item['image'] ?? '',
            'country': country,
            'isHalal': isHalal,
            'readyInMinutes': item['readyInMinutes'] ?? '-',
            'servings': item['servings'] ?? '-',
            'rating': 4 + Random().nextDouble() * 0.9,
            'original_data': item,
          };
        }).toList();
        recipes.value = mapped;
      }
    } catch (_) {}
  }
}
