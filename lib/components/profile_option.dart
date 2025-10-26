import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const ProfileOption({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: items.map((item) {
          return ListTile(
            leading: Icon(item['icon'], color: Colors.grey[600]),
            title: Text(
              item['title'],
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            onTap: () {},
          );
        }).toList(),
      ),
    );
  }
}
