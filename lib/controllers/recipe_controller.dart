import '../repositories/recipe_repository.dart';

class RecipeController {
  final RecipeRepository repository = RecipeRepository();

  Future<List<dynamic>> searchRecipes(String keyword) async {
    return await repository.fetchRecipesByFilter(keyword);
  }
}
