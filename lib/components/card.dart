import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/detail_recipe_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../controllers/detail_recipe_controller.dart';

class RecipeCard extends StatelessWidget {
  final dynamic recipe; // bisa Map atau RecipeModel

  const RecipeCard({super.key, required this.recipe});

  bool get _isMap => recipe is Map;

  // Getter dinamis
  String get image => _isMap ? (recipe['image'] ?? '') : (recipe.image ?? '');
  String get title => _isMap ? (recipe['title'] ?? '-') : (recipe.title ?? '-');
  bool get isHalal =>
      _isMap ? (recipe['isHalal'] ?? false) : (recipe.isHalal ?? false);
  String get country =>
      _isMap ? (recipe['country'] ?? '') : (recipe.country ?? '');
  String get time => _isMap
      ? (recipe['readyInMinutes'] != null
            ? '${recipe['readyInMinutes']}'
            : '—')
      : (recipe.time ?? '—');
  String get serving => _isMap
      ? (recipe['servings'] != null ? '${recipe['servings']}' : '—')
      : (recipe.serving ?? '—');
  double get rating =>
      _isMap ? (recipe['rating'] ?? 4.0).toDouble() : (recipe.rating ?? 4.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailRecipeView(
              controller: DetailRecipeController(recipe: recipe),
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: Colors.grey[50],
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
              child: image.isNotEmpty
                  ? (image.startsWith('http')
                        ? Image.network(
                            image,
                            height: 110,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            image,
                            height: 110,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ))
                  : Container(
                      height: 110,
                      width: double.infinity,
                      color: Colors.grey[50],
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
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isHalal)
                        Container(
                          height: 18,
                          width: 18,
                          margin: const EdgeInsets.only(left: 4),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            HugeIcons.strokeRoundedHalal,
                            color: Colors.green[500],
                            size: 13,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    country,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InfoItem(HugeIcons.strokeRoundedClock01, time),
                          const SizedBox(width: 6),
                          InfoItem(HugeIcons.strokeRoundedRiceBowl01, serving),
                        ],
                      ),
                      RatingStars(rating),
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
        Icon(icon, size: 12, color: Colors.grey[500]),
        const SizedBox(width: 3),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 10.5,
            color: Colors.grey[500],
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
          color: filled || half ? Colors.amber[500] : Colors.grey[300],
        );
      }),
    );
  }
}
