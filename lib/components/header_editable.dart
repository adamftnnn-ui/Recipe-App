import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class InfoBox extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController timeController;
  final TextEditingController servingController;
  final String? selectedCountry;
  final bool isHalal;
  final String? selectedImage;
  final VoidCallback onImageTap;
  final ValueChanged<String?> onCountryChanged;
  final ValueChanged<bool> onHalalChanged;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onTimeChanged;
  final ValueChanged<String> onServingChanged;

  const InfoBox({
    super.key,
    required this.titleController,
    required this.timeController,
    required this.servingController,
    required this.selectedCountry,
    required this.isHalal,
    required this.selectedImage,
    required this.onImageTap,
    required this.onCountryChanged,
    required this.onHalalChanged,
    required this.onTitleChanged,
    required this.onTimeChanged,
    required this.onServingChanged,
  });

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(fontSize: 13.5, color: Colors.grey[400]),
      filled: true,
      fillColor: const Color(0xFFF9FAFB),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onImageTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: selectedImage != null
                  ? Image.asset(
                      selectedImage!,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 160,
                      width: double.infinity,
                      color: const Color(0xFFF2F3F5),
                      alignment: Alignment.center,
                      child: Text(
                        'Tap to add image',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: titleController,
            decoration: _inputDecoration('Recipe Title'),
            onChanged: onTitleChanged,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: DropdownButtonFormField<String>(
                  decoration: _inputDecoration(
                    'Country',
                  ).copyWith(isDense: true),
                  items: ['Indonesia', 'Italy', 'Japan', 'India']
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: GoogleFonts.poppins(fontSize: 13.5),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onCountryChanged,
                  value: selectedCountry,
                  borderRadius: BorderRadius.circular(14),
                  icon: const Icon(
                    HugeIcons.strokeRoundedArrowDown01,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Halal',
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          color: Colors.grey[700],
                        ),
                      ),
                      Switch(
                        value: isHalal,
                        activeColor: const Color(0xFF4CAF50),
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: const Color(0xFFE0E0E0),
                        onChanged: onHalalChanged,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: timeController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('Time').copyWith(
                    suffixText: 'min',
                    suffixStyle: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 13.5,
                    ),
                  ),
                  onChanged: onTimeChanged,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: servingController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('Serving').copyWith(
                    suffixText: 'portion',
                    suffixStyle: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 13.5,
                    ),
                  ),
                  onChanged: onServingChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
