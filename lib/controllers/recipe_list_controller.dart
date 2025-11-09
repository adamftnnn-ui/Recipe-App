import 'package:flutter/foundation.dart';
import 'dart:math';
import '../controllers/api_services.dart';

class RecipeListController {
  final ValueNotifier<List<String>> suggestions = ValueNotifier<List<String>>(
    [],
  );
  final ValueNotifier<List<dynamic>> recipes = ValueNotifier<List<dynamic>>([]);

  Future<void> fetchSuggestionsFromApi() async {
    try {
      final endpoint = "recipes/random?number=6";
      final result = await ApiService.getData(endpoint);
      if (result != null && result.containsKey('recipes')) {
        final List<dynamic> rawRecipes = result['recipes'] as List<dynamic>;
        final List<String> newSuggestions = rawRecipes
            .map((item) {
              final title = (item['title'] ?? '').toString();
              final words = title.split(' ');
              return words.take(2).join(' ');
            })
            .where((s) => s.isNotEmpty)
            .toList();
        suggestions.value = newSuggestions.isEmpty
            ? ['Nasi Goreng', 'Sop Ayam', 'Ikan Bakar']
            : newSuggestions;
      } else {
        suggestions.value = ['Nasi Goreng', 'Sop Ayam', 'Ikan Bakar'];
      }
    } catch (e) {
      print("Error fetching suggestions: $e");
      suggestions.value = ['Nasi Goreng', 'Sop Ayam', 'Ikan Bakar'];
    }
  }

  Future<void> fetchRecipesByQuery(String query) async {
    recipes.value = [];
    try {
      final q = Uri.encodeQueryComponent(query);
      final endpoint =
          "recipes/complexSearch?query=$q&number=10&addRecipeInformation=true";
      final result = await ApiService.getData(endpoint);
      if (result != null && result.containsKey('results')) {
        final List<dynamic> rawRecipes = result['results'] as List<dynamic>;
        final mappedRecipes = rawRecipes.map((item) {
          final cuisines = item['cuisines'];
          String country = 'Global';
          if (cuisines is List && cuisines.isNotEmpty)
            country = cuisines[0].toString();
          final isHalal =
              !(item['vegetarian'] == true || item['vegan'] == true);
          return {
            'image': item['image'] ?? '',
            'title': item['title'] ?? 'Tanpa Judul',
            'isHalal': isHalal,
            'country': country,
            'readyInMinutes': item['readyInMinutes'] ?? '-',
            'servings': item['servings'] ?? '-',
            'rating': 4.0 + Random().nextDouble() * 0.9,
            'id': item['id'],
            'original_data': item,
          };
        }).toList();
        recipes.value = mappedRecipes;
      } else {
        recipes.value = [];
      }
    } catch (e) {
      print("Error fetching recipes: $e");
      recipes.value = [];
    }
  }
}
