import 'package:flutter/foundation.dart';
import '../models/recipe_model.dart';
import '../controllers/api_services.dart';
import 'dart:math';

class TrendingRecipeController {
  final ValueNotifier<List<RecipeModel>> trendingRecipes = ValueNotifier([]);

  final ApiService apiService;

  TrendingRecipeController(this.apiService);

  List<RecipeModel> getTrendingRecipes() => trendingRecipes.value;

  Future<void> fetchTrendingRecipes() async {
    trendingRecipes.value = [];

    try {
      // Endpoint populer Spoonacular
      final endpoint =
          "recipes/complexSearch?sort=popularity&number=10&addRecipeInformation=true";

      final result = await ApiService.getData(endpoint);

      if (result != null && result.containsKey('results')) {
        final List<dynamic> rawRecipes = result['results'];

        final List<RecipeModel> mappedRecipes = rawRecipes.map((item) {
          final List<String> ingredients =
              (item['extendedIngredients'] as List?)
                  ?.map((ing) => ing['original']?.toString() ?? '')
                  .where((s) => s.isNotEmpty)
                  .toList() ??
              [];

          final List<String> instructions =
              (item['analyzedInstructions'] as List?)
                  ?.expand(
                    (instList) => (instList['steps'] as List? ?? []).map(
                      (s) => s['step']?.toString() ?? '',
                    ),
                  )
                  .where((s) => s.isNotEmpty)
                  .toList() ??
              [];

          final Map<String, String> nutrition = {};
          if (item['nutrition']?['nutrients'] is List) {
            for (var n in item['nutrition']['nutrients']) {
              if (n['name'] != null &&
                  n['amount'] != null &&
                  n['unit'] != null) {
                nutrition[n['name']] = "${n['amount']} ${n['unit']}";
              }
            }
          }

          return RecipeModel(
            id: item['id'] ?? 0,
            image: item['image'] ?? '',
            title: item['title'] ?? 'Resep Tanpa Judul',
            country: (item['cuisines'] is List && item['cuisines'].isNotEmpty)
                ? item['cuisines'][0]
                : 'Global',
            isHalal: !(item['vegetarian'] == true || item['vegan'] == true),
            readyInMinutes: '${item['readyInMinutes'] ?? '-'}′',
            servings: '${item['servings'] ?? '-'}',
            rating: 4.0 + Random().nextDouble() * 0.9,
            ingredients: ingredients,
            instructions: instructions,
            nutrition: nutrition,
            original: item,
          );
        }).toList();

        trendingRecipes.value = mappedRecipes;
      }
    } catch (e) {
      print("Error fetching trending recipes: $e");
      trendingRecipes.value = [];
    }
  }
}
