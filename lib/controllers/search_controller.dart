import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SearchControllerr {
  Future<List<dynamic>> searchRecipes(String keyword) async {
    if (keyword.isEmpty) return [];
    final endpoint =
        'recipes/complexSearch?query=${Uri.encodeComponent(keyword)}&number=10&addRecipeInformation=true&addRecipeInstructions=true';
    final response = await ApiService.getData(endpoint);
    if (response != null && response['results'] != null) {
      return response['results'] as List<dynamic>;
    }
    return [];
  }
}
