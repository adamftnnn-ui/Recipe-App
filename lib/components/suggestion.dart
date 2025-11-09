import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/recipe_list_controller.dart';
import '../views/recipe_list_view.dart';

class Suggestion extends StatefulWidget {
  final RecipeListController? controller;

  const Suggestion({super.key, this.controller});

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  late final RecipeListController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? RecipeListController();

    // Hanya fetch jika Suggestion membuat controller sendiri
    if (_ownsController) {
      _controller.fetchSuggestionsFromApi();
    }
  }

  @override
  void dispose() {
    // Hanya dispose controller jika dibuat oleh widget ini
    if (_ownsController) {
      try {
        _controller.suggestions.dispose();
        _controller.recipes.dispose();
      } catch (_) {}
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: _controller.suggestions,
      builder: (context, suggestions, _) {
        if (suggestions.isEmpty) {
          return const SizedBox(height: 30);
        }

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeListView(
                          initialKeyword: label,
                          title: label,
                          recipes: const [],
                        ),
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
