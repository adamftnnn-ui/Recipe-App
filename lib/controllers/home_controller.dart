import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/recipe_model.dart';
import '../models/event_model.dart';
import '../repositories/user_repository.dart';
import '../repositories/recipe_repository.dart';
import '../repositories/event_repository.dart';

class HomeController {
  final UserRepository userRepository = UserRepository();
  final RecipeRepository recipeRepository = RecipeRepository();
  final EventRepository eventRepository = EventRepository();

  Future<UserModel> fetchUser() async {
    return await userRepository.fetchUser();
  }

  Future<List<String>> fetchSuggestions() async {
    return await recipeRepository.fetchSuggestions();
  }

  Future<List<RecipeModel>> fetchTrendingRecipes() async {
    return await recipeRepository.fetchTrendingRecipes();
  }

  Future<List<EventModel>> fetchEvents() async {
    return await eventRepository.fetchEvents();
  }
}
