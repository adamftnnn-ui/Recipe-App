// lib/controllers/home_controller.dart
import '../models/user_model.dart';
import '../models/recipe_model.dart';

class HomeController {
  final UserModel user = UserModel(
    name: 'Adam',
    avatarUrl: 'assets/images/avatar.jpg',
  );

  final List<String> banners = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  final Map<String, List<String>> categoryData = {
    'Halal': ['Halal', 'Non-Halal'],
    'Diet': ['Vegetarian', 'Vegan', 'Keto'],
    'Hidangan': ['Utama', 'Pembuka', 'Penutup'],
    'Acara': ['Ulang Tahun', 'Ramadhan', 'Natal'],
    'Negara': ['Indonesia', 'Malaysia', 'Thailand', 'Vietnam', 'Jepang'],
  };

  final List<String> suggestions = [
    'Mangut Lele',
    'Sop Ayam',
    'Nasi Goreng',
    'Ikan Bakar',
    'Tumis Kangkung',
    'Rawon Daging',
  ];

  final List<dynamic> trendingRecipes = [
    // RecipeModel(
    //   image: 'assets/images/banner2.png',
    //   title: 'Nasi Goreng Spesial',
    //   country: 'Indonesia',
    //   isHalal: true,
    //   readyInMinutes: '15′',
    //   servings: '2',
    //   rating: 4.8,
    //   ingredients: [
    //     'Nasi putih 2 piring',
    //     'Telur 2 butir',
    //     'Kecap manis 2 sdm',
    //     'Bawang merah 3 siung',
    //   ],
    //   instructions: [
    //     'Panaskan minyak di wajan.',
    //     'Tumis bawang hingga harum.',
    //     'Masukkan telur, orak-arik hingga matang.',
    //     'Tambahkan nasi dan kecap, aduk rata.',
    //   ],
    //   nutrition: {
    //     'Kalori': '350 kkal',
    //     'Protein': '12 g',
    //     'Lemak': '10 g',
    //     'Karbohidrat': '50 g',
    //   },
    // ),
    // RecipeModel(
    //   image: 'assets/images/banner2.png',
    //   title: 'Ayam Bakar Madu',
    //   country: 'Indonesia',
    //   isHalal: true,
    //   readyInMinutes: '25′',
    //   servings: '3',
    //   rating: 4.9,
    //   ingredients: [
    //     'Ayam 500 gr',
    //     'Madu 3 sdm',
    //     'Bawang putih 2 siung',
    //     'Garam dan merica secukupnya',
    //   ],
    //   instructions: [
    //     'Marinasi ayam dengan madu dan bumbu.',
    //     'Diamkan 30 menit.',
    //     'Bakar ayam hingga matang dan harum.',
    //   ],
    //   nutrition: {
    //     'Kalori': '420 kkal',
    //     'Protein': '35 g',
    //     'Lemak': '20 g',
    //     'Karbohidrat': '15 g',
    //   },
    // ),
  ];
}
