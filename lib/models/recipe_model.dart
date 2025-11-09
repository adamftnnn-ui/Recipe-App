class RecipeModel {
  final int id;
  final String image;
  final String title;
  final String country;
  final bool isHalal;
  final String readyInMinutes;
  final String servings;
  final double rating;
  final List<String> ingredients;
  final List<String> instructions;
  final Map<String, String> nutrition;
  final Map<String, dynamic>? original;

  RecipeModel({
    required this.id,
    required this.image,
    required this.title,
    required this.country,
    required this.isHalal,
    required this.readyInMinutes,
    required this.servings,
    required this.rating,
    required this.ingredients,
    required this.instructions,
    required this.nutrition,
    this.original,
  });

  factory RecipeModel.fromMap(dynamic m) {
    if (m == null) {
      return RecipeModel(
        id: 0,
        image: '',
        title: 'Tanpa Judul',
        country: 'Global',
        isHalal: true,
        readyInMinutes: '-',
        servings: '-',
        rating: 4.5,
        ingredients: [],
        instructions: [],
        nutrition: {},
        original: null,
      );
    }

    final Map<String, dynamic> map = (m is Map<String, dynamic>) ? m : {};

    String extractImage() {
      if (map['image'] is String && (map['image'] as String).isNotEmpty)
        return map['image'];
      if (map['images'] is List && (map['images'] as List).isNotEmpty)
        return (map['images'] as List).first.toString();
      return '';
    }

    List<String> parseIngredients() {
      if (map['extendedIngredients'] is List) {
        return (map['extendedIngredients'] as List)
            .map((e) {
              if (e is Map &&
                  (e['originalString'] != null || e['original'] != null)) {
                return (e['originalString'] ?? e['original'] ?? '').toString();
              }
              return e.toString();
            })
            .where((s) => s.isNotEmpty)
            .toList();
      }
      if (map['ingredients'] is List) {
        return (map['ingredients'] as List).map((e) => e.toString()).toList();
      }
      return [];
    }

    List<String> parseInstructions() {
      if (map['analyzedInstructions'] is List &&
          (map['analyzedInstructions'] as List).isNotEmpty) {
        final steps = <String>[];
        for (final part in map['analyzedInstructions']) {
          if (part is Map && part['steps'] is List) {
            for (final s in part['steps']) {
              if (s is Map && s['step'] != null)
                steps.add(s['step'].toString());
            }
          }
        }
        return steps;
      }
      if (map['instructions'] is String) {
        final raw = map['instructions'].toString();
        return raw
            .split(RegExp(r'\n+|(?<=\.)\s+'))
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      }
      return [];
    }

    Map<String, String> parseNutrition() {
      final out = <String, String>{};
      if (map['nutrition'] is Map && map['nutrition']['nutrients'] is List) {
        for (final n in map['nutrition']['nutrients']) {
          if (n is Map &&
              n['name'] != null &&
              n['amount'] != null &&
              n['unit'] != null) {
            out[n['name'].toString()] =
                '${n['amount'].toString()} ${n['unit'].toString()}';
          }
        }
      } else if (map['nutrition'] is Map) {
        map['nutrition'].forEach((k, v) {
          out[k.toString()] = v.toString();
        });
      }
      return out;
    }

    final cuisines = map['cuisines'];
    final country = (cuisines is List && cuisines.isNotEmpty)
        ? cuisines[0].toString()
        : (map['country']?.toString() ?? 'Global');

    final isHalal = !(map['vegetarian'] == true || map['vegan'] == true);

    final ready =
        map['readyInMinutes']?.toString() ??
        map['ready_time']?.toString() ??
        '-';
    final servings =
        map['servings']?.toString() ?? map['servings_count']?.toString() ?? '-';

    final rating = (map['spoonacularScore'] is num)
        ? (map['spoonacularScore'] as num).toDouble() / 20.0 + 3.0
        : (map['rating'] is num ? (map['rating'] as num).toDouble() : 4.5);

    final id = (map['id'] is int)
        ? map['id'] as int
        : int.tryParse(map['id']?.toString() ?? '') ?? 0;

    return RecipeModel(
      id: id,
      image: extractImage(),
      title: map['title']?.toString() ?? 'Tanpa Judul',
      country: country,
      isHalal: isHalal,
      readyInMinutes: ready,
      servings: servings,
      rating: rating,
      ingredients: parseIngredients(),
      instructions: parseInstructions(),
      nutrition: parseNutrition(),
      original: map,
    );
  }
}
