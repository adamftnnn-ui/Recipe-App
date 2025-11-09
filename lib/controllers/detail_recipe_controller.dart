import '../models/recipe_model.dart';

class DetailRecipeController {
  final RecipeModel recipe;

  DetailRecipeController({required dynamic recipeData})
    : recipe = RecipeModel.fromMap(recipeData);

  List<String> getIngredients() => recipe.ingredients;

  List<String> getInstructions() => recipe.instructions;

  Map<String, String> getNutrition() => recipe.nutrition;
}
