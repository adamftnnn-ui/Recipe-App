import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../views/search_view.dart';
// import '../controllers/api_services.dart'; // ApiService tidak digunakan di sini, bisa dihapus jika tidak diperlukan.

class SearchBarr extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final Function(String)? onSubmitted;
  final VoidCallback? onClear;
  final EdgeInsetsGeometry? padding;
  final bool enableNavigation;
  final String? placeholder;

  const SearchBarr({
    super.key,
    this.controller,
    this.initialValue,
    this.onSubmitted,
    this.onClear,
    this.padding,
    this.enableNavigation = true,
    this.placeholder,
  });

  @override
  State<SearchBarr> createState() => _SearchBarrState();
}

class _SearchBarrState extends State<SearchBarr> {
  late TextEditingController searchController;
  final FocusNode _focusNode = FocusNode();

  // ✅ DYNAMIC: Tambahkan listener untuk memicu rebuild saat teks berubah (untuk ikon 'clear')
  @override
  void initState() {
    super.initState();
    searchController =
        widget.controller ??
        TextEditingController(text: widget.initialValue ?? "");

    // Listener ini penting agar ikon 'clear' (suffixIcon) muncul/hilang secara dinamis
    searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchTextChanged); // Hapus listener
    if (widget.controller == null) searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // 🔄 Fungsi untuk rebuild widget saat teks berubah
  void _onSearchTextChanged() {
    // Panggil setState hanya jika teks controller berubah
    // Hal ini penting agar tombol 'clear' bisa muncul dan hilang
    setState(() {});
  }

  // 🗑️ Fungsi untuk mengosongkan search bar
  void _clearSearch() {
    searchController.clear();
    widget.onClear?.call();
    // setState sudah dipanggil oleh _onSearchTextChanged,
    // tapi panggil lagi untuk memastikan onSubmitted yang mungkin mengubah UI lain terpicu
    setState(() {});
  }

  // ➡️ Fungsi untuk navigasi (ketika search bar diketuk saat enableNavigation=true)
  void _handleTap() {
    if (widget.enableNavigation) {
      _focusNode.unfocus();
      // ✅ DYNAMIC: Ganti menjadi navigasi pushReplacement jika Anda ingin menghapus rute sebelumnya dari stack,
      // tetapi mempertahankan `push` sesuai kode asli.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchView()),
      );
    }
  }

  // 🚀 Fungsi yang dipanggil saat user menekan 'Enter' atau 'Selesai'
  void _handleSubmitted(String value) {
    widget.onSubmitted?.call(value);
    // Hapus clear() di sini, karena jika digunakan di SearchView,
    // kita ingin nilai tetap ada setelah pencarian selesai.
    // Jika perlu clear, itu akan ditangani di _handleSearch pada SearchView.
    // searchController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // 🎨 DYNAMIC: Ambil warna tema
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;

    return Padding(
      // ✅ DYNAMIC: Padding dari parameter widget
      padding: widget.padding ?? const EdgeInsets.fromLTRB(20, 6, 20, 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                // ✅ DYNAMIC: Warna background putih dari tema/konstanta.
                // Di sini menggunakan Colors.white (sudah dinamis dalam konteks Flutter)
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    // ✅ DYNAMIC: Opacity dan warna shadow
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  // ✅ DYNAMIC: Ikon dengan warna yang dinamis
                  Icon(
                    HugeIcons.strokeRoundedSearch01,
                    color: Colors.grey[700],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      // ✅ DYNAMIC: readOnly berdasarkan parameter
                      readOnly: widget.enableNavigation,
                      focusNode: _focusNode,
                      controller: searchController,
                      style: GoogleFonts.poppins(
                        // ✅ DYNAMIC: Warna teks dari tema jika perlu, di sini menggunakan black87
                        fontSize: 13.5,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        // ✅ DYNAMIC: Placeholder dari parameter widget
                        hintText:
                            widget.placeholder ?? 'Cari resep atau bahan...',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 13.5,
                          color: Colors.grey[500],
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        // ✅ DYNAMIC: Ikon clear (close) hanya muncul jika ada teks
                        suffixIcon: searchController.text.isEmpty
                            ? null
                            : IconButton(
                                icon: Icon(
                                  Icons.close_rounded,
                                  size: 18,
                                  color: Colors.grey[500],
                                ),
                                onPressed: _clearSearch,
                              ),
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 30,
                          minHeight: 30,
                        ),
                      ),
                      onTap: _handleTap,
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 🎤 Ikon Mic
          const SizedBox(width: 10),
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            // ✅ DYNAMIC: Tambahkan fungsionalitas onTap untuk ikon Mic jika ada (saat ini kosong/statis)
            child: GestureDetector(
              onTap: () {
                // TODO: Implementasi fungsi pengenalan suara/mic di sini
                print("Mic/Voice search activated!");
              },
              child: Icon(
                HugeIcons.strokeRoundedMic01,
                color: Colors.grey[700],
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
