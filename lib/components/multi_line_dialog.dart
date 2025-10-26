import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MultiLineDialog extends StatelessWidget {
  final String title;
  final String hint;
  final void Function(List<String>) onSave;

  const MultiLineDialog({
    super.key,
    required this.title,
    required this.onSave,
    this.hint = '',
  });

  @override
  Widget build(BuildContext context) {
    final textC = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        padding: const EdgeInsets.all(18),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: textC,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
              ),
              maxLines: 6,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel', style: GoogleFonts.poppins()),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (textC.text.trim().isEmpty) return;
                    final lines = textC.text
                        .split('\n')
                        .map((e) => e.trim())
                        .where((e) => e.isNotEmpty)
                        .toList();
                    onSave(lines);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
