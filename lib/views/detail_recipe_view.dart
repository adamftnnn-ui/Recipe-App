import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/components/nutrition_section.dart';
import '../controllers/detail_recipe_controller.dart';
import '../components/header_section.dart';
import '../components/ingredients_section.dart';
import '../components/instruction_section.dart';

class DetailRecipeView extends StatelessWidget {
  final DetailRecipeController controller;

  const DetailRecipeView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final recipe = controller.recipe;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Detail Resep',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 38),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    HeaderSection(recipe: recipe),
                    const SizedBox(height: 16),
                    IngredientsSection(
                      ingredients: controller.getIngredients(),
                    ),
                    const SizedBox(height: 16),
                    InstructionSection(
                      instructions: controller.getInstructions(),
                    ),
                    const SizedBox(height: 16),
                    NutritionReadonly(nutrition: controller.getNutrition()),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
