class SearchHistoryModel {
  final String keyword;

  SearchHistoryModel({required this.keyword});

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    return SearchHistoryModel(keyword: json['keyword'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'keyword': keyword};
  }
}
