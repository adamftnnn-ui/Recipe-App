import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NutritionDialog extends StatelessWidget {
  final void Function(String label, String value) onSave;

  const NutritionDialog({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final labelC = TextEditingController();
    final valueC = TextEditingController();

    InputDecoration _inputDecoration(String hint) {
      return InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(fontSize: 13.5, color: Colors.grey[400]),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 1.2),
        ),
      );
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        padding: const EdgeInsets.all(18),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Nutrition',
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: labelC,
              decoration: _inputDecoration('Label (e.g. Protein)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: valueC,
              decoration: _inputDecoration('Value'),
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
                    if (labelC.text.trim().isEmpty) return;
                    onSave(labelC.text.trim(), valueC.text.trim());
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
