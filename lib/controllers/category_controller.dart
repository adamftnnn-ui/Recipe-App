import 'package:flutter/material.dart';
import '../views/category_modal.dart';
import '../views/recipe_list_view.dart';
import '../controllers/recipe_list_controller.dart';

class CategoryController {
  static void showCategoryModal(
    BuildContext context, {
    required String title,
    Function(String)? onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => CategoryModal(
        title: title,
        items: _getCategoryItems(title),
        onSelected: (value) async {
          Navigator.pop(context); // tutup modal
          if (title == 'Halal') {
            // tetap tampilkan pilihan Halal/Non-Halal
            final query = value.toLowerCase() == 'halal' ? 'halal' : '';
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RecipeListView(initialKeyword: query),
              ),
            );
          } else if (title == 'Acara') {
            // Acara manual
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RecipeListView(initialKeyword: value),
              ),
            );
          } else {
            // Diet, Negara, Hidangan -> panggil API Spoonacular
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RecipeListView(initialKeyword: value),
              ),
            );
          }
          if (onSelected != null) onSelected(value);
        },
      ),
    );
  }

  static List<String> _getCategoryItems(String title) {
    switch (title) {
      case 'Halal':
        return ['Halal', 'Non-Halal'];
      case 'Diet':
        return ['Vegetarian', 'Vegan', 'Keto'];
      case 'Hidangan':
        return ['Utama', 'Pembuka', 'Penutup'];
      case 'Acara':
        return ['Ulang Tahun', 'Ramadhan', 'Natal'];
      case 'Negara':
        return ['Indonesia', 'Malaysia', 'Thailand', 'Vietnam', 'Jepang'];
      default:
        return [];
    }
  }
}
