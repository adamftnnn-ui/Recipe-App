import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../models/recipe_model.dart';

class HeaderSection extends StatelessWidget {
  final RecipeModel recipe;

  const HeaderSection({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: recipe.image.isNotEmpty
                ? Image.asset(
                    recipe.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 100,
                    height: 100,
                    color: const Color(0xFFF2F3F5),
                    alignment: Alignment.center,
                    child: Text(
                      'No Image',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        recipe.title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (recipe.isHalal)
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          HugeIcons.strokeRoundedHalal,
                          color: Color(0xFF43A047),
                          size: 14,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  recipe.country,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _InfoItem(
                      icon: HugeIcons.strokeRoundedClock01,
                      text: '${recipe.time} Menit',
                    ),
                    const SizedBox(width: 8),
                    _InfoItem(
                      icon: HugeIcons.strokeRoundedRiceBowl01,
                      text: '${recipe.serving} Porsi',
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _RatingStars(rating: recipe.rating),
                    const Spacer(),
                    Icon(
                      HugeIcons.strokeRoundedShare01,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      HugeIcons.strokeRoundedBookmark01,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: Colors.grey[600]),
        const SizedBox(width: 3),
        Text(
          text,
          style: GoogleFonts.poppins(fontSize: 11.5, color: Colors.grey[700]),
        ),
      ],
    );
  }
}

class _RatingStars extends StatelessWidget {
  final double rating;
  const _RatingStars({required this.rating});

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
