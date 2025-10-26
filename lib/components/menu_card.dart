import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuInfoCard extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const MenuInfoCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFE),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Column(
            children: [
              ListTile(
                leading: Icon(item['icon'], size: 20, color: Colors.grey[700]),
                title: Text(
                  item['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey,
                ),
                onTap: () {},
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              if (index != items.length - 1)
                const Divider(height: 1, indent: 12, endIndent: 12),
            ],
          );
        }),
      ),
    );
  }
}
