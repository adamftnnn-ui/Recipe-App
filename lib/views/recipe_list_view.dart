import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../components/card.dart';
import '../components/search_bar.dart';

class RecipeListView extends StatefulWidget {
  final String initialKeyword;
  final String title;
  final List<dynamic> recipes;

  const RecipeListView({
    super.key,
    required this.initialKeyword,
    // ✅ DYNAMIC: Tetap gunakan default value, tetapi ini dari properti.
    this.title = 'Daftar Resep',
    required this.recipes,
  });

  @override
  State<RecipeListView> createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _fadeIn = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // TODO: Tambahkan fungsi untuk menangani pencarian ulang jika SearchBarr digunakan
  // Misalnya: Future<void> _handleReSearch(String newKeyword) async { ... }

  @override
  Widget build(BuildContext context) {
    // ✅ DYNAMIC: Menggunakan Theme untuk warna latar belakang
    final theme = Theme.of(context);

    final double spacing = 14;
    final double screenWidth = MediaQuery.of(context).size.width;
    // ✅ DYNAMIC: Perhitungan lebar kartu agar dinamis sesuai ukuran layar
    // Mengasumsikan layout 2 kolom: (Lebar Layar - Total Padding Samping - Jarak Antar Kartu) / 2
    final double infoCardWidth = (screenWidth - (20 * 2) - spacing) / 2;

    final recipes = widget.recipes;

    // 🚫 Hapus print debugging statis: print('recipes: $recipes');

    return SafeArea(
      child: Scaffold(
        // ✅ DYNAMIC: Gunakan warna background dari Theme
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Column(
          children: [
            // --- Header Kembali ---
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
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        HugeIcons.strokeRoundedArrowLeft01,
                        size: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Center(
                      child: Text(
                        // ✅ DYNAMIC: Menggunakan title dari properti widget
                        widget.title,
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

            // --- Search Bar dengan Keyword Awal ---
            SearchBarr(
              initialValue: widget.initialKeyword,
              // ✅ DYNAMIC: Atur ini menjadi true jika user bisa tap untuk navigasi ke Search View
              enableNavigation: true,
              // Jika Anda ingin user bisa search ulang di halaman ini:
              // onSubmitted: _handleReSearch,
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 8),
            ),

            const SizedBox(height: 8),

            // --- Daftar Resep / Empty State ---
            Expanded(
              child: FadeTransition(
                opacity: _fadeIn,
                child: recipes.isEmpty
                    ? Center(
                        // ✅ DYNAMIC: Empty State (Ketika recipes kosong)
                        child: Padding(
                          padding: const EdgeInsets.only(top: 120),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedSearch01,
                                color: Colors.grey[300],
                                size: 60,
                              ),
                              const SizedBox(height: 14),
                              Text(
                                // ✅ DYNAMIC: Pesan disesuaikan dengan keyword
                                'Tidak ada resep untuk "${widget.initialKeyword}"',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: theme
                                      .colorScheme
                                      .error, // ✅ DYNAMIC: Gunakan warna error dari tema
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        // ✅ DYNAMIC: Daftar resep (Ketika recipes tidak kosong)
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Wrap(
                            spacing: spacing,
                            runSpacing: spacing,
                            // ✅ DYNAMIC: Mapping data resep
                            children: recipes.map((recipe) {
                              // Asumsi: recipe adalah Map<String, dynamic>
                              return SizedBox(
                                width: infoCardWidth,
                                child: RecipeCard(
                                  // ✅ DYNAMIC: Pastikan data yang dilempar sesuai kontrak RecipeCard
                                  recipe: {
                                    'id': recipe['id'],
                                    'title': recipe['title'],
                                    'image': recipe['image'],
                                    'readyInMinutes': recipe['readyInMinutes'],
                                    'servings': recipe['servings'],
                                    'sourceUrl': recipe['sourceUrl'],
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
