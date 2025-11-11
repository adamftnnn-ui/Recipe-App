import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../components/card.dart';
import '../components/search_bar.dart';
import '../controllers/recipe_list_controller.dart';
import '../controllers/profile_controller.dart';
import 'create_recipe_view.dart';
import '../controllers/create_recipe_controller.dart';

class RecipeListView extends StatefulWidget {
  final String initialKeyword;
  final String title;
  final List<dynamic>? recipes;
  final bool showDelete;
  final ProfileController? profileController;

  const RecipeListView({
    super.key,
    required this.initialKeyword,
    this.title = 'Daftar Resep',
    this.recipes,
    this.showDelete = false,
    this.profileController,
  });

  @override
  State<RecipeListView> createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeIn;
  late RecipeListController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = RecipeListController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _fadeIn = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.recipes != null && widget.recipes!.isNotEmpty) {
        controller.recipes.value = widget.recipes!;
        _animationController.forward();
        setState(() => isLoading = false);
      } else {
        await controller.fetchRecipesByFilter(widget.initialKeyword);
        _animationController.forward();
        setState(() => isLoading = false);
      }
    });
  }

  void _deleteRecipe(int index) {
    if (widget.showDelete && widget.profileController != null) {
      widget.profileController!.removeRecipeAt(index);
      setState(() {});
    }
  }

  void _editRecipe(int index) {
    if (widget.profileController == null) return;
    final recipe = controller.recipes.value[index];
    final createController = CreateRecipeController();

    createController.setTitle(recipe['title'] ?? '');
    createController.setCountry(recipe['country'] ?? '');
    createController.setHalal(recipe['isHalal'] ?? false);
    createController.setTime(recipe['readyInMinutes']?.toString() ?? '');
    createController.setServing(recipe['servings']?.toString() ?? '');
    createController.setIngredients(
      List<String>.from(recipe['ingredients'] ?? []),
    );
    createController.setSteps(List<String>.from(recipe['steps'] ?? []));
    createController.setNutritions(
      List<Map<String, String>>.from(recipe['nutritions'] ?? []),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreateRecipeView(
          controller: createController,
          profileController: widget.profileController!,
          isEditMode: true,
          editIndex: index,
        ),
      ),
    ).then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double spacing = 14;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double infoCardWidth = (screenWidth - (20 * 2) - spacing) / 2;

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
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
              enableNavigation: true,
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 8),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FadeTransition(
                opacity: _fadeIn,
                child: ValueListenableBuilder<List<dynamic>>(
                  valueListenable: controller.recipes,
                  builder: (context, recipes, _) {
                    if (isLoading)
                      return const Center(child: CircularProgressIndicator());

                    if (recipes.isEmpty) {
                      return Center(
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
                                'Tidak ada resep untuk "${widget.initialKeyword}"',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: theme.colorScheme.error,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Wrap(
                          spacing: spacing,
                          runSpacing: spacing,
                          children: List.generate(recipes.length, (index) {
                            final recipe = recipes[index];
                            return SizedBox(
                              width: infoCardWidth,
                              child: RecipeCard(
                                recipe: recipe,
                                image: recipe['image'] ?? '',
                                title: recipe['title'] ?? 'Tanpa Judul',
                                isHalal: recipe['isHalal'] ?? true,
                                country: recipe['country'] ?? 'Tidak Diketahui',
                                readyInMinutes:
                                    '${recipe['readyInMinutes'] ?? '-'}',
                                servings: '${recipe['servings'] ?? '-'}',
                                rating: (recipe['rating'] ?? 4.5).toDouble(),
                                showDelete: widget.showDelete,
                                onDelete: () => _deleteRecipe(index),
                                showEdit: widget.showDelete,
                                onEdit: () => _editRecipe(index),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
