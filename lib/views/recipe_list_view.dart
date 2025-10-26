// lib/views/recipe_list_view.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/recipe_controller.dart';
import '../components/card.dart';
import '../components/search_bar.dart';
import '../models/recipe_model.dart';

class RecipeListView extends StatefulWidget {
  final String initialKeyword;
  final String title;

  const RecipeListView({
    super.key,
    required this.initialKeyword,
    this.title = 'Daftar Resep',
  });

  @override
  State<RecipeListView> createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView>
    with SingleTickerProviderStateMixin {
  late RecipeController _controller;
  late List<RecipeModel> _filteredRecipes;
  late AnimationController _animationController;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = RecipeController();
    _filteredRecipes = _controller.searchRecipes(widget.initialKeyword);

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

  void _handleSearch(String keyword) {
    setState(() {
      _filteredRecipes = _controller.searchRecipes(keyword);
    });
  }

  void _handleClear() {
    setState(() {
      _filteredRecipes = _controller.allRecipes;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double spacing = 14;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double InfoCardWidth = (screenWidth - (spacing * 3) - 16) / 2;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        body: Column(
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
            SearchBarr(
              initialValue: widget.initialKeyword,
              onSubmitted: _handleSearch,
              onClear: _handleClear,
              enableNavigation: false,
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 8),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FadeTransition(
                opacity: _fadeIn,
                child: _filteredRecipes.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 120),
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                color: Colors.grey[400],
                                size: 60,
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'Tidak ditemukan',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Wrap(
                            spacing: spacing,
                            runSpacing: spacing,
                            children: _filteredRecipes.map((recipe) {
                              return SizedBox(
                                width: InfoCardWidth,
                                child: RecipeCard(recipe: recipe),
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
