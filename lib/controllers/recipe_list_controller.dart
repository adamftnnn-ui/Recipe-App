import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/controllers/api_services.dart'; // Ganti dengan path ApiService Anda
import 'package:flutter_application_1/models/recipe_model.dart'; // Ganti dengan path RecipeModel Anda
import 'dart:math';

class RecipeListController {
  // Properti untuk menyimpan daftar saran pencarian (diubah menjadi ValueNotifier)
  final ValueNotifier<List<String>> suggestions = ValueNotifier<List<String>>(
    [],
  );

  // Properti untuk menyimpan daftar resep hasil pencarian
  final ValueNotifier<List<dynamic>> recipes = ValueNotifier<List<dynamic>>([]);

  // Properti dinamis (non-static)
  final ApiService apiService;

  RecipeListController(this.apiService);

  // Getter yang mengembalikan nilai dari ValueNotifier
  List<String> getSuggestions() => suggestions.value;

  // --- 1. Metode untuk Mengambil Saran (Suggestions) dari API ---
  Future<void> fetchSuggestionsFromApi() async {
    try {
      // Kita gunakan endpoint random untuk mendapatkan resep dan mengambil title sebagai saran.
      final endpoint = "recipes/random?number=6";

      final result = await ApiService.getData(endpoint);

      if (result != null && result.containsKey('recipes')) {
        final List<dynamic> rawRecipes = result['recipes'];

        // Ambil judul resep dan gunakan sebagai saran pencarian.
        final List<String> newSuggestions = rawRecipes
            .map(
              (item) => item['title'].toString().split(' ').take(2).join(' '),
            ) // Ambil 2 kata pertama
            .toList();

        // Update ValueNotifier
        suggestions.value = newSuggestions;
      } else {
        // Jika gagal, gunakan saran default (fallback)
        suggestions.value = const ['Nasi Goreng', 'Sop Ayam', 'Ikan Bakar'];
      }
    } catch (e) {
      print("Error fetching suggestions: $e");
      // Fallback
      suggestions.value = const ['Nasi Goreng', 'Sop Ayam', 'Ikan Bakar'];
    }
  }

  // --- 2. Metode untuk Mengambil Daftar Resep dari API ---
  Future<void> fetchRecipesByQuery(String query) async {
    // Reset status loading atau error jika ada
    recipes.value = [];

    try {
      final endpoint =
          "recipes/complexSearch?query=$query&number=10&addRecipeInformation=true";
      // Tambahkan addRecipeInformation=true agar data lebih lengkap

      final result = await ApiService.getData(endpoint);

      if (result != null && result.containsKey('results')) {
        final List<dynamic> rawRecipes = result['results'];

        final mappedRecipes = rawRecipes.map((item) {
          // Data resep dari complexSearch + addRecipeInformation=true
          return {
            'image': item['image'] ?? '',
            'title': item['title'] ?? 'Tanpa Judul',

            // Mengambil/mengolah properti yang diperlukan RecipeCard
            'isHalal':
                item['vegetarian'] == false &&
                item['vegan'] ==
                    false, // Contoh logika sederhana isHalal/Non-Veg
            'country': item['cuisines'] != null && item['cuisines'].isNotEmpty
                ? item['cuisines'][0]
                : 'Global',
            'readyInMinutes': item['readyInMinutes'] ?? 30,
            'servings': item['servings'] ?? 4,
            // Spoonacular tidak menyediakan field 'rating', kita simulasikan
            'rating':
                4.0 +
                Random().nextDouble() * 0.9, // Rating acak antara 4.0 dan 4.9

            'id': item['id'],
            'original_data': item, // Simpan data asli untuk DetailController
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
