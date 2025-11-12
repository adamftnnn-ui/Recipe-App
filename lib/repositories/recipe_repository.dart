import '../models/recipe_model.dart';
import '../services/api_service.dart';

class RecipeRepository {
  Future<List<String>> fetchSuggestions() async {
    final result = await ApiService.getData("recipes/random?number=6");
    if (result != null && result.containsKey('recipes')) {
      return (result['recipes'] as List)
          .map((item) => item['title']?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
    }
    return [];
  }

  Future<List<RecipeModel>> fetchTrendingRecipes() async {
    final endpoint =
        "recipes/complexSearch?sort=popularity&number=10&addRecipeInformation=true";
    final result = await ApiService.getData(endpoint);
    if (result != null && result.containsKey('results')) {
      return (result['results'] as List)
          .map((item) => RecipeModel.fromMap(item))
          .toList();
    }
    return [];
  }

  Future<List<dynamic>> fetchRecipesByFilter(String filter) async {
    if (filter.isEmpty) return [];
    final q = Uri.encodeQueryComponent(filter);
    final result = await ApiService.getData(
      "recipes/complexSearch?query=$q&number=20&addRecipeInformation=true&includeNutrition=true",
    );
    if (result != null && result.containsKey('results')) {
      return (result['results'] as List).map((item) {
        final cuisines = item['cuisines'];
        String country = 'Global';
        if (cuisines is List && cuisines.isNotEmpty)
          country = cuisines[0].toString();
        final isHalal = !(item['vegetarian'] == true || item['vegan'] == true);
        return {
          'id': item['id'],
          'title': item['title'] ?? 'Tanpa Judul',
          'image': item['image'] ?? '',
          'country': country,
          'isHalal': isHalal,
          'readyInMinutes': item['readyInMinutes'] ?? '-',
          'servings': item['servings'] ?? '-',
          'rating': 4 + (item['spoonacularScore'] ?? 80) / 20.0,
          'original_data': item,
        };
      }).toList();
    }
    return [];
  }
}
