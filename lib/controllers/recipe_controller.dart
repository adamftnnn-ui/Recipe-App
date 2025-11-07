class RecipeController {
  final List<dynamic> _allRecipes = [
  ];

  List<dynamic> searchRecipes(String keyword) {
    final lower = keyword.toLowerCase();
    return _allRecipes
        .where((r) => r.title.toLowerCase().contains(lower))
        .toList();
  }

  List<dynamic> get allRecipes => _allRecipes;
}
