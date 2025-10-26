import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/detail_recipe_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../models/recipe_model.dart';
import '../controllers/detail_recipe_controller.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailRecipeView(
              controller: DetailRecipeController(
                recipe: recipe, // <-- pakai named parameter
              ),
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: const Color(0xFFFDFDFE),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              child: recipe.image.isNotEmpty
                  ? Image.asset(
                      recipe.image,
                      height: 110,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 110,
                      width: double.infinity,
                      color: const Color(0xFFF2F3F5),
                      alignment: Alignment.center,
                      child: Text(
                        "Belum ada gambar",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          recipe.title,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (recipe.isHalal)
                        Container(
                          height: 18,
                          width: 18,
                          margin: const EdgeInsets.only(left: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            HugeIcons.strokeRoundedHalal,
                            color: Color(0xFF43A047),
                            size: 13,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    recipe.country,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InfoItem(HugeIcons.strokeRoundedClock01, recipe.time),
                          const SizedBox(width: 6),
                          InfoItem(
                            HugeIcons.strokeRoundedRiceBowl01,
                            recipe.serving,
                          ),
                        ],
                      ),
                      RatingStars(recipe.rating),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const InfoItem(this.icon, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: Colors.grey[600]),
        const SizedBox(width: 3),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 10.5,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class RatingStars extends StatelessWidget {
  final double rating;
  const RatingStars(this.rating, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final filled = index < rating.floor();
        final half = index == rating.floor() && rating % 1 >= 0.5;
        return Icon(
          half ? Icons.star_half_rounded : Icons.star_rounded,
          size: 12,
          color: filled || half
              ? const Color(0xFFFFC107)
              : Colors.grey.shade300,
        );
      }),
    );
  }
}
