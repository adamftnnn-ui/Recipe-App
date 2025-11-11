import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _spoonacularBase =
      "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com";
  static const Map<String, String> _spoonacularHeaders = {
    "X-RapidAPI-Key": "734e974423msh0deb8b81bbb0357p102b61jsnb747e22182e7",
    "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
  };

  static const String _geminiBase =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent";
  static const Map<String, String> _geminiHeaders = {
    "x-goog-api-key": "AIzaSyBQlIsEe_BvvkOUqvH_G-j_414UZ-H70dM",
    "Content-Type": "application/json",
  };

  static Future<Map<String, dynamic>?> getData(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse("$_spoonacularBase/$endpoint"),
        headers: _spoonacularHeaders,
      );
      if (response.statusCode == 200) return jsonDecode(response.body);
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>> sendGeminiMessage(String message) async {
    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": message},
          ],
        },
      ],
    });

    try {
      final response = await http.post(
        Uri.parse(_geminiBase),
        headers: _geminiHeaders,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates']?[0]?['content']?[0]?['text'] ?? '';
        return {'reply': text};
      } else {
        return {'reply': 'Maaf, AI tidak merespon.'};
      }
    } catch (e) {
      return {'reply': 'Maaf, terjadi kesalahan.'};
    }
  }
}
