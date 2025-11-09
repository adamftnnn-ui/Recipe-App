import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../views/search_view.dart';

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

  @override
  void initState() {
    super.initState();
    searchController =
        widget.controller ??
        TextEditingController(text: widget.initialValue ?? "");
    searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchTextChanged);
    if (widget.controller == null) searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {});
  }

  void _clearSearch() {
    searchController.clear();
    widget.onClear?.call();
    setState(() {});
  }

  void _handleTap() {
    if (widget.enableNavigation) {
      _focusNode.unfocus();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchView()),
      );
    }
  }

  void _handleSubmitted(String value) {
    widget.onSubmitted?.call(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;

    return Padding(
      padding: widget.padding ?? const EdgeInsets.fromLTRB(20, 6, 20, 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Icon(
                    HugeIcons.strokeRoundedSearch01,
                    color: Colors.grey[700],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      readOnly: widget.enableNavigation,
                      focusNode: _focusNode,
                      controller: searchController,
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
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
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
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
