import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/create_recipe_controller.dart';
import '../controllers/profile_controller.dart';
import '../components/multi_line_editable.dart';
import '../components/nutrition_editable.dart';
import '../components/header_editable.dart';

class CreateRecipeView extends StatefulWidget {
  final CreateRecipeController controller;
  final ProfileController profileController;

  const CreateRecipeView({
    super.key,
    required this.controller,
    required this.profileController,
  });

  @override
  State<CreateRecipeView> createState() => _CreateRecipeViewState();
}

class _CreateRecipeViewState extends State<CreateRecipeView> {
  final TextEditingController _titleC = TextEditingController();
  final TextEditingController _timeC = TextEditingController();
  final TextEditingController _servingC = TextEditingController();

  String? _selectedCountry;
  bool _isHalal = false;
  String? _selectedImage;

  final List<String> _ingredients = [];
  final List<String> _steps = [];
  final List<Map<String, String>> _nutritions = [];

  void _postRecipe() {
    final recipe = {
      'title': widget.controller.title,
      'country': widget.controller.country,
      'isHalal': widget.controller.isHalal,
      'readyInMinutes': widget.controller.time,
      'servings': widget.controller.serving,
      'ingredients': widget.controller.ingredients,
      'steps': widget.controller.steps,
      'nutritions': widget.controller.nutritions,
      'image': _selectedImage ?? '',
    };

    widget.profileController.addRecipe(recipe);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Resep berhasil diposting!')));

    widget.controller.clearAll();
    setState(() {
      _titleC.clear();
      _timeC.clear();
      _servingC.clear();
      _selectedCountry = null;
      _isHalal = false;
      _ingredients.clear();
      _steps.clear();
      _nutritions.clear();
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Buat Resep',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InfoBox(
                titleController: _titleC,
                timeController: _timeC,
                servingController: _servingC,
                selectedCountry: _selectedCountry,
                isHalal: _isHalal,
                selectedImage: _selectedImage,
                onImageTap: () {},
                onCountryChanged: (v) {
                  setState(() => _selectedCountry = v);
                  widget.controller.setCountry(v ?? '');
                },
                onHalalChanged: (v) {
                  setState(() => _isHalal = v);
                  widget.controller.setHalal(v);
                },
                onTitleChanged: (v) => widget.controller.setTitle(v),
                onTimeChanged: (v) => widget.controller.setTime(v),
                onServingChanged: (v) => widget.controller.setServing(v),
              ),
              const SizedBox(height: 20),
              MultiLineSection(
                title: 'Bahan-bahan',
                items: _ingredients,
                bullet: true,
                onAdd: (lines) {
                  setState(() => _ingredients.addAll(lines));
                  widget.controller.setIngredients(_ingredients);
                },
              ),
              const SizedBox(height: 20),
              MultiLineSection(
                title: 'Langkah-langkah',
                items: _steps,
                isNumbered: true,
                onAdd: (lines) {
                  setState(() => _steps.addAll(lines));
                  widget.controller.setSteps(_steps);
                },
              ),
              const SizedBox(height: 20),
              NutritionEditable(
                nutritions: _nutritions,
                onAdd: (label, value) {
                  setState(
                    () => _nutritions.add({'label': label, 'value': value}),
                  );
                  widget.controller.setNutritions(_nutritions);
                },
                onRemove: (index) {
                  setState(() => _nutritions.removeAt(index));
                  widget.controller.setNutritions(_nutritions);
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _postRecipe,
                  child: const Text('Posting Resep'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
