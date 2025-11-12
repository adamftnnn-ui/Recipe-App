import 'package:flutter/material.dart';
import '../repositories/recipe_repository.dart';

class RecipeListController {
  final RecipeRepository recipeRepository = RecipeRepository();

  Future<List<dynamic>> fetchRecipesByFilter(String filter) async {
    return await recipeRepository.fetchRecipesByFilter(filter);
  }
}