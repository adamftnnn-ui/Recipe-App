import 'package:flutter/material.dart';

class ProfileController {
  // Data user utama
  final ValueNotifier<Map<String, dynamic>> userNotifier =
      ValueNotifier<Map<String, dynamic>>({
        'name': 'Nama User',
        'country': 'Indonesia',
        'gender': 'Laki-laki',
        'avatarUrl': '', // Path image lokal atau kosong
        'uploads': 0, // jumlah posting, otomatis dihitung dari userRecipes
      });

  // Daftar resep user
  final ValueNotifier<List<Map<String, dynamic>>> userRecipes =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  // Menambahkan resep baru
  void addRecipe(Map<String, dynamic> recipe) {
    userRecipes.value = [...userRecipes.value, recipe];
    _updateUploadCount();
  }

  // Menghapus resep berdasarkan index
  void removeRecipeAt(int index) {
    if (index >= 0 && index < userRecipes.value.length) {
      final temp = [...userRecipes.value];
      temp.removeAt(index);
      userRecipes.value = temp;
      _updateUploadCount();
    }
  }

  // Update resep di index tertentu
  void updateRecipeAt(int index, Map<String, dynamic> newData) {
    if (index >= 0 && index < userRecipes.value.length) {
      final temp = [...userRecipes.value];
      temp[index] = newData;
      userRecipes.value = temp;
      _updateUploadCount();
    }
  }

  // Update jumlah posting di userNotifier
  void _updateUploadCount() {
    final current = Map<String, dynamic>.from(userNotifier.value);
    current['uploads'] = userRecipes.value.length;
    userNotifier.value = current;
  }

  // Update data user
  void updateUser(Map<String, dynamic> newUserData) {
    userNotifier.value = {...userNotifier.value, ...newUserData};
  }

  void clearAll() {
    userNotifier.value = {
      'name': '',
      'country': '',
      'gender': '',
      'avatarUrl': '',
      'uploads': 0,
    };
    userRecipes.value = [];
  }
}
