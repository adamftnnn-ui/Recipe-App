// lib/views/components/trending.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/recipe_model.dart';
// Asumsikan ini adalah versi RecipeCard yang telah diubah menjadi dinamis
import '../components/card.dart';
import '../../views/recipe_list_view.dart';

class Trending extends StatelessWidget {
  // Properti sudah final (dinamis), tidak ada statis.
  final List<RecipeModel> recipes;

  const Trending({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Resep Trending",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: 0.2,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecipeListView(
                        // Nilai-nilai di sini sudah dinamis (bukan statis) karena ditetapkan saat runtime
                        initialKeyword: '',
                        title: 'Resep Trending',
                        recipes: const [],
                      ),
                    ),
                  );
                },
                child: Text(
                  "Lihat semua",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.green[500],
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 190,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: recipes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final item = recipes[index];

                // PENTING: Jika RecipeCard diubah menjadi dinamis (tidak lagi menggunakan getter
                // untuk Map/Model), kita perlu memetakan data di sini:
                return RecipeCard(
                  recipe: item, // Meneruskan objek model aslinya
                  image: item.image, // Meneruskan properti secara eksplisit
                  title: item.title,
                  isHalal: item.isHalal,
                  country: item.country,
                  readyInMinutes:
                      item.readyInMinutes?.toString() ??
                      '—', // Asumsi nama field
                  servings:
                      item.servings?.toString() ?? '—', // Asumsi nama field
                  rating: item.rating?.toDouble() ?? 4.0, // Asumsi nama field
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
