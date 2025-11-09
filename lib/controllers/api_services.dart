import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com";

  static const Map<String, String> _headers = {
    "X-RapidAPI-Key": "734e974423msh0deb8b81bbb0357p102b61jsnb747e22182e7",
    "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
  };

  static Future<Map<String, dynamic>?> getData(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/$endpoint"),
        headers: _headers,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        print("Request failed: ${response.statusCode}");
        print("Response body: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error during GET: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> postData(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/$endpoint"),
        headers: {..._headers, "Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        print("POST failed: ${response.statusCode}");
        print("Response body: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error during POST: $e");
      return null;
    }
  }
}
