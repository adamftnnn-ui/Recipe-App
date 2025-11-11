import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/search_bar.dart';
import '../controllers/api_services.dart';
import 'recipe_list_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isLoading = false;
  List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('search_history') ?? [];
    setState(() {
      _history = history;
    });
  }

  Future<void> _addToHistory(String keyword) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('search_history') ?? [];
    if (!history.contains(keyword)) {
      history.insert(0, keyword);
      if (history.length > 10) {
        history.removeLast();
      }
      await prefs.setStringList('search_history', history);
      _loadHistory();
    }
  }

  Future<void> _clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('search_history');
    _loadHistory();
  }

  Future<void> _handleSearch(String value) async {
    final keyword = value.trim();
    if (keyword.isEmpty) return;

    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    try {
      final endpoint =
          'recipes/complexSearch?query=${Uri.encodeComponent(keyword)}&number=10&addRecipeInformation=true&addRecipeInstructions=true';
      final response = await ApiService.getData(endpoint);

      await _addToHistory(keyword);

      if (response != null && response['results'] != null) {
        final List<dynamic> recipes = response['results'] as List<dynamic>;
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  RecipeListView(initialKeyword: keyword, recipes: recipes),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Resep tidak ditemukan atau API bermasalah'),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan saat mencari resep: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final history = _history;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        HugeIcons.strokeRoundedArrowLeft01,
                        size: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Pencarian',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 38),
                ],
              ),
            ),
            SearchBarr(
              controller: _searchController,
              enableNavigation: false,
              onSubmitted: _handleSearch,
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 8),
              placeholder: 'Cari resep atau bahan',
            ),
            if (_isLoading)
              LinearProgressIndicator(
                minHeight: 2,
                backgroundColor: Theme.of(
                  context,
                ).primaryColor.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            Expanded(
              child: history.isEmpty
                  ? Center(
                      child: Text(
                        'Tidak ada riwayat pencarian.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey[500],
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Terbaru',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Lihat Semua',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green[500],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...history.map((keyword) {
                            final isLast = keyword == history.last;
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _searchController.text = keyword;
                                    _handleSearch(keyword);
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  splashColor: Colors.grey.withOpacity(0.08),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 2,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.history_rounded,
                                          color: Colors.grey[500],
                                          size: 20,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            keyword,
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey[700],
                                              letterSpacing: 0.1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (!isLast)
                                  Container(
                                    height: 0.5,
                                    color: Colors.grey.withOpacity(0.25),
                                  ),
                              ],
                            );
                          }).toList(),
                          const SizedBox(height: 20),
                          Center(
                            child: GestureDetector(
                              onTap: _clearHistory,
                              child: Text(
                                'Hapus Riwayat',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.5,
                                  color: Colors.red[500],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
