import '../models/search_history_model.dart';

class SearchBarrController {
  final List<SearchHistoryModel> _history = [];

  void addHistory(String keyword) {
    final k = keyword.trim();
    if (k.isEmpty) return;
    final newItem = SearchHistoryModel(keyword: k);
    final existingIndex = _history.indexWhere(
      (item) => item.keyword.toLowerCase() == k.toLowerCase(),
    );
    if (existingIndex != -1) _history.removeAt(existingIndex);
    _history.insert(0, newItem);
    if (_history.length > 10) _history.removeLast();
  }

  List<SearchHistoryModel> getHistory() => List.from(_history);

  void clearHistory() => _history.clear();
}
