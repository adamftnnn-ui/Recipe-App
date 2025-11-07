import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../controllers/api_services.dart';
import '../controllers/recipe_list_controller.dart';
import '../controllers/trending_recipe_controller.dart';
import '../controllers/event_controller.dart';
import '../components/banner.dart';
import '../components/header.dart';
import '../components/category.dart';
import '../components/search_bar.dart';
import '../components/suggestion.dart';
import '../components/trending.dart';
import '../components/event.dart';
import '../models/event_model.dart';
import '../models/recipe_model.dart';

// --- UBAH DARI StatelessWidget MENJADI StatefulWidget ---
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // --- Inisialisasi Dinamis ---
  final ApiService _apiService = ApiService(); // Hanya perlu satu instance
  late final RecipeListController _recipeListController;
  late final TrendingRecipeController _trendingController;
  late final EventController _eventController;

  final UserModel _user = UserModel(
    name: 'Adam',
    avatarUrl: 'assets/images/avatar.jpg',
  );
  final List<String> _localBanners = const [
    // Tetap lokal karena ini bukan data API Spoonacular
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  @override
@override
  void initState() {
    super.initState();
    _recipeListController = RecipeListController(_apiService);
    _trendingController = TrendingRecipeController(_apiService);
    _eventController = EventController(); // ✅ tanpa argumen

    _recipeListController.fetchSuggestionsFromApi();
    _trendingController.fetchTrendingRecipes();
    _eventController.fetchAllEvents();
  }


  @override
  void dispose() {
    // Bersihkan ValueNotifier
    _recipeListController.suggestions.dispose();
    _trendingController.trendingRecipes.dispose();
    _eventController.events.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            HeaderWidget(user: _user),
            BannerWidget(banners: _localBanners),

            const CategoryWidget(),

            SearchBarr(
              placeholder: 'Cari resep atau bahan...',
              enableNavigation: true,
            ),

            // --- 1. Suggestion (Mendengarkan Perubahan Suggestions) ---
            ValueListenableBuilder<List<String>>(
              valueListenable: _recipeListController.suggestions,
              builder: (context, suggestions, child) {
                // Meneruskan seluruh controller untuk akses suggestions
                return Suggestion(controller: _recipeListController);
              },
            ),

            // --- 2. Trending (Mendengarkan Perubahan Trending Recipes) ---
            ValueListenableBuilder<List<RecipeModel>>(
              valueListenable: _trendingController.trendingRecipes,
              builder: (context, recipes, child) {
                if (recipes.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                // Meneruskan List<RecipeModel> yang sudah diproses
                return Trending(recipes: recipes);
              },
            ),

            // --- 3. Event (Mendengarkan Perubahan Events) ---
            ValueListenableBuilder<List<EventModel>>(
              valueListenable: _eventController.events,
              builder: (context, events, child) {
                if (events.isEmpty) {
                  return const SizedBox.shrink();
                }
                // Meneruskan List<EventModel>
                return Event(events: events);
              },
            ),
          ],
        ),
      ),
    );
  }
}
