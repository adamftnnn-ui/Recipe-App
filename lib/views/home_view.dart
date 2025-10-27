import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../controllers/recipe_list_controller.dart';
import '../controllers/recipe_controller.dart';
import '../controllers/event_controller.dart';
import '../components/banner.dart';
import '../components/header.dart';
import '../components/category.dart';
import '../components/search_bar.dart';
import '../components/suggestion.dart';
import '../components/trending.dart';
import '../components/event.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserModel(name: 'Adam', avatarUrl: 'assets/images/avatar.jpg');
    final banners = [
      'assets/images/banner1.png',
      'assets/images/banner2.png',
      'assets/images/banner3.png',
    ];
    final recipeController = RecipeController();
    final eventController = EventController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            HeaderWidget(user: user),
            BannerWidget(banners: banners),
            const CategoryWidget(),
            SearchBarr(
              placeholder: 'Cari resep atau bahan...',
              enableNavigation: true,
            ),
            Suggestion(controller: RecipeListController()),
            Trending(recipes: recipeController.allRecipes),
            Event(events: eventController.getAllEvents()),
          ],
        ),
      ),
    );
  }
}
