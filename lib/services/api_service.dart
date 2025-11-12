import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com';
  static const Map<String, String> headers = {
    'X-Rapidapi-Key':
        '734e974423msh0deb8b81bbb0357p102b61jsnb747e22182e7',
    'X-Rapidapi-Host': 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com',
  };

  static Future<Map<String, dynamic>?> getData(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print('Error getData: $e');
    }
    return null;
  }

  static Future<Map<String, dynamic>?> converseWithSpoonacular(
    String text,
    String contextId,
  ) async {
    final endpoint =
        "food/converse?text=${Uri.encodeQueryComponent(text)}&contextId=$contextId";
    return await getData(endpoint);
  }

  static Future<Map<String, dynamic>?> sendGeminiMessage(String message) async {
    // Tetap ada jika diperlukan, tapi tidak digunakan untuk chat
    return null;
  }

  static Future<Map<String, dynamic>?> getRecipeDetail(int recipeId) async {
    final endpoint = 'recipes/$recipeId/information?includeNutrition=true';
    return await getData(endpoint);
  }
}
