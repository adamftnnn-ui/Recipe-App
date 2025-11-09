import 'package:flutter/material.dart';
import '../models/chat_model.dart';
import '../controllers/api_services.dart';

class ChatController {
  final ValueNotifier<List<ChatMessage>> chatsNotifier = ValueNotifier([]);

  final String userAvatar = 'assets/images/avatar.jpg';
  final String assistantAvatar = 'assets/images/avatar_ai.jpg';
  final String userName = 'Adam';
  final String assistantName = 'Kama';

  void addInitialGreeting(BuildContext context) {
    chatsNotifier.value = [
      ChatMessage(
        avatarUrl: assistantAvatar,
        name: assistantName,
        role: 'Assistant',
        message:
            'Halo $userName, apa yang ingin kamu tanyakan atau masak hari ini?',
        time: TimeOfDay.now().format(context),
        isAssistant: true,
      ),
    ];
  }

  void addUserMessage(String text, BuildContext context) {
    final message = ChatMessage(
      avatarUrl: userAvatar,
      name: userName,
      role: null,
      message: text,
      time: TimeOfDay.now().format(context),
      isAssistant: false,
    );
    chatsNotifier.value = [...chatsNotifier.value, message];
  }

  void addAssistantMessage(String text, BuildContext context) {
    final message = ChatMessage(
      avatarUrl: assistantAvatar,
      name: assistantName,
      role: 'Assistant',
      message: text,
      time: TimeOfDay.now().format(context),
      isAssistant: true,
    );
    chatsNotifier.value = [...chatsNotifier.value, message];
  }

  // Fungsi utama: pilih API mana yang digunakan
  Future<void> getAssistantReply(
    String userMessage,
    BuildContext context,
  ) async {
    try {
      final keyword = userMessage.toLowerCase();

      // Jika ada kata 'resep', 'burger', 'ayam', 'nasi', gunakan Spoonacular
      final recipeKeywords = [
        'resep',
        'burger',
        'ayam',
        'nasi',
        'sop',
        'ikan',
        'cake',
        'kue',
      ];
      final isRecipeQuery = recipeKeywords.any((k) => keyword.contains(k));

      if (isRecipeQuery) {
        await _fetchRecipe(userMessage, context);
      } else {
        await _fetchGeminiReply(userMessage, context);
      }
    } catch (e) {
      addAssistantMessage('Maaf, terjadi kesalahan.', context);
      print("Error getAssistantReply: $e");
    }
  }

  // Panggil Spoonacular
  Future<void> _fetchRecipe(String userMessage, BuildContext context) async {
    try {
      final query = Uri.encodeQueryComponent(userMessage);
      final result = await ApiService.getData(
        "recipes/complexSearch?query=$query&number=1&addRecipeInformation=true",
      );

      if (result != null &&
          result.containsKey('results') &&
          (result['results'] as List).isNotEmpty) {
        final item = result['results'][0];
        final title = item['title'] ?? 'Resep Tanpa Judul';
        final ready = item['readyInMinutes'] ?? '-';
        final servings = item['servings'] ?? '-';
        final ingredients = (item['extendedIngredients'] as List? ?? [])
            .map((e) => e['original']?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList();

        String reply = '**$title**\n';
        reply += 'Porsi: $servings\n';
        reply += 'Waktu masak: $ready menit\n';
        reply += 'Bahan:\n';
        for (var ing in ingredients) {
          reply += '- $ing\n';
        }

        addAssistantMessage(reply.trim(), context);
      } else {
        addAssistantMessage(
          'Maaf, saya tidak menemukan resep untuk "$userMessage".',
          context,
        );
      }
    } catch (e) {
      addAssistantMessage(
        'Maaf, terjadi kesalahan saat mengambil resep.',
        context,
      );
      print("Error fetching recipe: $e");
    }
  }

  // Panggil Gemini API
  Future<void> _fetchGeminiReply(
    String userMessage,
    BuildContext context,
  ) async {
    try {
      final response = await ApiService.sendGeminiMessage(userMessage);
      final replyText = response['reply'] ?? 'Maaf, AI tidak merespon.';
      addAssistantMessage(replyText, context);
    } catch (e) {
      addAssistantMessage('Maaf, terjadi kesalahan pada AI.', context);
      print("Error fetching Gemini reply: $e");
    }
  }
}
