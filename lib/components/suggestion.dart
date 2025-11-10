import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/recipe_list_controller.dart';
import '../views/recipe_list_view.dart';

class Suggestion extends StatelessWidget {
  final RecipeListController controller;

  const Suggestion({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: controller.suggestions,
      builder: (context, suggestions, _) {
        if (suggestions.isEmpty) return const SizedBox(height: 30);

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
          child: SizedBox(
            height: 30,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final label = suggestions[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    // Pindah ke RecipeListView dengan keyword dinamis
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            RecipeListView(initialKeyword: label),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500],
                        height: 1.1,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
