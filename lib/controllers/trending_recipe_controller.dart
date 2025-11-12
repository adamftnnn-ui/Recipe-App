import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../repositories/recipe_repository.dart';

class TrendingRecipeController {
  final RecipeRepository repository = RecipeRepository();
  final ValueNotifier<List<RecipeModel>> trendingRecipes = ValueNotifier([]);

  Future<void> fetchTrendingRecipes() async {
    trendingRecipes.value = await repository.fetchTrendingRecipes();
  }
}
