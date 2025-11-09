// lib/views/components/category_widget.dart
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/recipe_list_controller.dart';
import '../views/recipe_list_view.dart';

final categoryData = {
  'Halal': ['Halal', 'Non-Halal'], // manual
  'Diet': ['Vegetarian', 'Vegan', 'Keto'],
  'Hidangan': ['Utama', 'Pembuka', 'Penutup'],
  'Acara': ['Ulang Tahun', 'Ramadhan', 'Natal'],
  'Negara': ['Indonesia', 'Malaysia', 'Thailand', 'Vietnam', 'Jepang'],
};

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'icon': HugeIcons.strokeRoundedHalal, 'label': 'Halal'},
      {'icon': HugeIcons.strokeRoundedHealth, 'label': 'Diet'},
      {'icon': HugeIcons.strokeRoundedPlate, 'label': 'Hidangan'},
      {'icon': HugeIcons.strokeRoundedSpoonAndFork, 'label': 'Acara'},
      {'icon': HugeIcons.strokeRoundedEarth, 'label': 'Negara'},
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: categories.map((item) {
                final label = item['label'] as String;
                return GestureDetector(
                  onTap: () async {
                    final items = categoryData[label]!;
                    final selected = await showModalBottomSheet<String>(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      builder: (_) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (_, i) => ListTile(
                            title: Text(items[i]),
                            onTap: () => Navigator.pop(context, items[i]),
                          ),
                        );
                      },
                    );
                    if (selected != null) {
                      String filterKeyword = selected;
                      if (label == 'Acara') {
                        if (selected.toLowerCase() == 'natal')
                          filterKeyword = 'Europe';
                        if (selected.toLowerCase() == 'ramadhan')
                          filterKeyword = 'Middle East';
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipeListView(
                            initialKeyword: filterKeyword,
                            title: 'Resep $selected',
                          ),
                        ),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: Colors.green[500],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          color: Colors.green[50],
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        label,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
