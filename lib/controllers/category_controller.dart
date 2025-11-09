import 'package:flutter/material.dart';
import '../views/category_modal.dart';
import '../views/recipe_list_view.dart';
import 'recipe_list_controller.dart';

class CategoryController {
  static void showCategoryModal(
    BuildContext context, {
    required String title,
    required List<String> items,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => CategoryModal(
        title: title,
        items: items,
        onSelected: (item) async {
          String filterKeyword = item;
          if (title == 'Acara') {
            switch (item.toLowerCase()) {
              case 'natal':
                filterKeyword = 'Europe';
                break;
              case 'ramadhan':
                filterKeyword = 'Ramadan';
                break;
              case 'ulang tahun':
                filterKeyword = 'Birthday';
                break;
            }
          } else if (title == 'Halal') {
            filterKeyword = item; // manual
          }

          final controller = RecipeListController();
          await controller.fetchRecipesByFilter(filterKeyword);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RecipeListView(
                initialKeyword: filterKeyword,
                title: 'Resep $item',
                recipes: controller.recipes.value,
              ),
            ),
          );
        },
      ),
    );
  }
}
