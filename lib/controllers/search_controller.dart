import '../models/search_history_model.dart';

class SearchBarrController {
  // 🚫 Hapus semua data statis (hardcoded) di sini
  final List<SearchHistoryModel> _history = [];
  // Sekarang _history dimulai sebagai daftar kosong,
  // dan akan diisi secara dinamis saat user melakukan pencarian.

  /// Metode baru untuk menambahkan keyword ke riwayat
  void addHistory(String keyword) {
    if (keyword.trim().isEmpty) return;

    final newHistoryItem = SearchHistoryModel(keyword: keyword.trim());

    // Cek apakah keyword sudah ada di riwayat
    final existingIndex = _history.indexWhere(
      (item) => item.keyword.toLowerCase() == keyword.trim().toLowerCase(),
    );

    // Jika sudah ada, hapus item lama
    if (existingIndex != -1) {
      _history.removeAt(existingIndex);
    }

    // Tambahkan item baru ke urutan pertama (paling atas/terbaru)
    _history.insert(0, newHistoryItem);

    // (Opsional) Batasi jumlah riwayat, misalnya 10 item terakhir
    if (_history.length > 10) {
      _history.removeLast();
    }
  }

  // Metode untuk mendapatkan riwayat
  List<dynamic> getHistory() => List.from(_history);

  // Metode untuk membersihkan seluruh riwayat
  void clearHistory() => _history.clear();
}
