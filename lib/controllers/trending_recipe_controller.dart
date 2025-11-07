// lib/controllers/trending_recipe_controller.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/controllers/api_services.dart'; // Sesuaikan path
import '../models/recipe_model.dart';
import 'dart:math';

class TrendingRecipeController {
  // ValueNotifier untuk menyimpan dan mengelola daftar resep yang diambil secara dinamis.
  // Menggunakan List<RecipeModel> agar ValueNotifier langsung menyimpan model yang benar.
  final ValueNotifier<List<RecipeModel>> trendingRecipes = ValueNotifier(
    <RecipeModel>[],
  );

  // Properti dinamis (non-static) untuk koneksi API.
  final ApiService apiService;

  // Constructor menerima ApiService
  TrendingRecipeController(this.apiService);

  // Getter yang mengembalikan nilai dari ValueNotifier
  List<RecipeModel> getTrendingRecipes() => trendingRecipes.value;

  // Metode untuk mengambil data resep trending dari API.
  Future<void> fetchTrendingRecipes() async {
    trendingRecipes.value = []; // Bersihkan resep saat mulai fetching

    try {
      // Menggunakan endpoint /recipes/random untuk menyimulasikan resep trending.
      // Kita meminta 6 resep. Kita tambahkan 'tags' untuk mendapatkan resep makanan.
      final endpoint = "recipes/random?number=6";

      final result = await ApiService.getData(endpoint);

      if (result != null && result.containsKey('recipes')) {
        final List<dynamic> rawRecipes = result['recipes'];

        // --- PROSES MAPPING DATA ---
        // Sekarang kita memetakan langsung ke RecipeModel sehingga widget menerima tipe yang benar.
        final List<RecipeModel> mappedRecipes = rawRecipes.map((item) {
          // Mengubah data API ke format yang dibutuhkan oleh RecipeCard dan RecipeModel:

          // 1. Dapatkan daftar instruksi/ingredients
          final List<String> ingredients =
              (item['extendedIngredients'] as List?)
                  ?.map((ing) => ing['original'].toString())
                  .toList() ??
              [];

          final List<String> instructions =
              (item['analyzedInstructions'] as List?)
                  ?.expand((instList) => instList['steps'] as List)
                  .map((step) => step['step'].toString())
                  .toList() ??
              [];

          // 2. Dapatkan informasi nutrisi (Spoonacular sering memberikan nutrisi dalam bentuk ringkasan)
          // Kita akan menyederhanakannya atau menggunakan nilai default.
          final Map<String, String> nutrition = {
            'Kalori':
                item['nutrition']?['nutrients']
                    ?.firstWhere(
                      (n) => n['title'] == 'Calories',
                      orElse: () => null,
                    )?['amount']
                    ?.toStringAsFixed(0) ??
                '— kkal',
            'Protein':
                item['nutrition']?['nutrients']
                    ?.firstWhere(
                      (n) => n['title'] == 'Protein',
                      orElse: () => null,
                    )?['amount']
                    ?.toStringAsFixed(1) ??
                '— g',
            'Lemak':
                item['nutrition']?['nutrients']
                    ?.firstWhere(
                      (n) => n['title'] == 'Fat',
                      orElse: () => null,
                    )?['amount']
                    ?.toStringAsFixed(1) ??
                '— g',
            'Karbohidrat':
                item['nutrition']?['nutrients']
                    ?.firstWhere(
                      (n) => n['title'] == 'Carbohydrates',
                      orElse: () => null,
                    )?['amount']
                    ?.toStringAsFixed(1) ??
                '— g',
          };

          // 3. Buat objek RecipeModel
          final recipeModel = RecipeModel(
            image: item['image'] ?? '',
            title: item['title'] ?? 'Resep Tanpa Judul',
            country: item['cuisines'] != null && item['cuisines'].isNotEmpty
                ? item['cuisines'][0]
                : 'Global',
            isHalal:
                item['vegetarian'] ==
                false, // Simplifikasi: non-vegetarian dianggap non-halal
            readyInMinutes: '${item['readyInMinutes'] ?? 30}′', // Format waktu
            servings: '${item['servings'] ?? 4}', // Format serving
            rating:
                4.0 +
                Random().nextDouble() * 0.9, // Simulasi rating (4.0 hingga 4.9)
            ingredients: ingredients,
            instructions: instructions,
            nutrition: nutrition,
          );

          // Kembalikan objek RecipeModel langsung
          return recipeModel;
        }).toList();

        // Update ValueNotifier
        trendingRecipes.value = mappedRecipes;
      }
    } catch (e) {
      print("Error fetching trending recipes: $e");
      // Jika terjadi error, daftar resep tetap kosong (atau bisa diisi dengan data fallback)
      trendingRecipes.value = [];
    }
  }
}
