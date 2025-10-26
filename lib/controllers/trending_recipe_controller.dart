// lib/controllers/trending_recipe_controller.dart
import '../models/recipe_model.dart';

class TrendingRecipeController {
  final List<RecipeModel> _trendingRecipes = [
    RecipeModel(
      image: 'assets/images/banner1.png',
      title: 'Nasi Goreng Spesial',
      country: 'Indonesia',
      isHalal: true,
      time: '15′',
      serving: '2',
      rating: 4.8,
      ingredients: [
        'Nasi putih 2 piring',
        'Telur 2 butir',
        'Kecap manis 2 sdm',
        'Bawang merah 3 siung',
      ],
      instructions: [
        'Panaskan minyak di wajan.',
        'Tumis bawang hingga harum.',
        'Masukkan telur, orak-arik hingga matang.',
        'Tambahkan nasi dan kecap, aduk rata.',
      ],
      nutrition: {
        'Kalori': '350 kkal',
        'Protein': '12 g',
        'Lemak': '10 g',
        'Karbohidrat': '50 g',
      },
    ),
    RecipeModel(
      image: 'assets/images/banner2.png',
      title: 'Ayam Bakar Madu',
      country: 'Indonesia',
      isHalal: true,
      time: '25′',
      serving: '3',
      rating: 4.9,
      ingredients: [
        'Ayam 500 gr',
        'Madu 3 sdm',
        'Bawang putih 2 siung',
        'Garam dan merica secukupnya',
      ],
      instructions: [
        'Marinasi ayam dengan madu dan bumbu.',
        'Diamkan 30 menit.',
        'Bakar ayam hingga matang dan harum.',
      ],
      nutrition: {
        'Kalori': '420 kkal',
        'Protein': '35 g',
        'Lemak': '20 g',
        'Karbohidrat': '15 g',
      },
    ),
    RecipeModel(
      image: 'assets/images/banner3.png',
      title: 'Mie Goreng Jawa',
      country: 'Indonesia',
      isHalal: true,
      time: '20′',
      serving: '2',
      rating: 4.7,
      ingredients: [
        'Mie telur 200 gr',
        'Sayuran campur 100 gr',
        'Kecap manis 2 sdm',
        'Bawang merah 2 siung',
      ],
      instructions: [
        'Rebus mie hingga matang.',
        'Tumis bawang dan sayuran.',
        'Masukkan mie dan kecap, aduk rata.',
      ],
      nutrition: {
        'Kalori': '300 kkal',
        'Protein': '10 g',
        'Lemak': '8 g',
        'Karbohidrat': '45 g',
      },
    ),
  ];

  List<RecipeModel> getTrendingRecipes() => _trendingRecipes;
}
