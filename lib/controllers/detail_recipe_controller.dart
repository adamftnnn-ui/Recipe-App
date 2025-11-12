import '../models/recipe_model.dart';
import '../services/api_service.dart';

class DetailRecipeController {
  late RecipeModel recipe;
  bool isLoaded = false;

  DetailRecipeController({required dynamic recipeData})
    : recipe = RecipeModel.fromMap(recipeData);

  Future<void> fetchRecipeFromApi(int recipeId) async {
    final data = await ApiService.getRecipeDetail(recipeId);
    if (data != null) {
      recipe = RecipeModel.fromMap(data);
      isLoaded = true;
    } else {
      throw Exception("Gagal memuat data resep dari API");
    }
  }

  List<String> getIngredients() => recipe.ingredients;

  List<String> getInstructions() => recipe.instructions;

  Map<String, String> getNutrition() => recipe.nutrition;
}
