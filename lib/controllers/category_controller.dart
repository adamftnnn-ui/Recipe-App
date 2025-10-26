import 'package:flutter/material.dart';
import '../views/category_modal.dart';

class CategoryController {
  static void showCategoryModal(
    BuildContext context, {
    required String title,
    required List<String> items,
    required Function(String) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) =>
          CategoryModal(title: title, items: items, onSelected: onSelected),
    );
  }
}
