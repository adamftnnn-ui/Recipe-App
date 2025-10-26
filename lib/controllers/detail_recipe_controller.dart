import '../models/recipe_model.dart';

class DetailRecipeController {
  final RecipeModel recipe;

  DetailRecipeController({required this.recipe});

  List<String> getIngredients() => recipe.ingredients;

  List<String> getInstructions() => recipe.instructions;

  Map<String, String> getNutrition() => recipe.nutrition;
}
