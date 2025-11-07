// lib/models/recipe_model.dart
class RecipeModel {
  final String image;
  final String title;
  final String country;
  final bool isHalal;
  final String readyInMinutes;
  final String servings;
  final double rating;
  final List<String> ingredients;
  final List<String> instructions;
  final Map<String, String> nutrition;

  RecipeModel({
    required this.image,
    required this.title,
    required this.country,
    required this.isHalal,
    required this.readyInMinutes,
    required this.servings,
    required this.rating,
    required this.ingredients,
    required this.instructions,
    required this.nutrition,
  });
}
