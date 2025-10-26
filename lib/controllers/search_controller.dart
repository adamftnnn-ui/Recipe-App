import '../models/search_history_model.dart';

class SearchBarrController {
  final List<SearchHistoryModel> _history = [
    SearchHistoryModel(keyword: 'Nasi Goreng Spesial'),
    SearchHistoryModel(keyword: 'Ayam Bakar Madu'),
    SearchHistoryModel(keyword: 'Mie Goreng Jawa'),
    SearchHistoryModel(keyword: 'Soto Ayam'),
    SearchHistoryModel(keyword: 'Bakso Kuah'),
  ];

  List<SearchHistoryModel> getHistory() => List.from(_history);

  void clearHistory() => _history.clear();
}
