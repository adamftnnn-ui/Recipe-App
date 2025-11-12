import '../services/api_service.dart';

class ChatRepository {
  Future<String> getConverseReply(String text, String contextId) async {
    final response = await ApiService.converseWithSpoonacular(text, contextId);
    return response?['answer'] ?? 'Maaf, AI tidak merespon.';
  }

  Future<Map<String, dynamic>?> getRecipe(String query) async {
    final result = await ApiService.getData(
      "recipes/complexSearch?query=${Uri.encodeQueryComponent(query)}&number=1&addRecipeInformation=true",
    );
    return result;
  }
}
