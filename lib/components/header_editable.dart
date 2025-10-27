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
      hintStyle: GoogleFonts.poppins(fontSize: 13.5, color: Colors.grey[500]),
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.green[500]!, width: 1.2),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      color: Colors.grey[50],
                      alignment: Alignment.center,
                      child: Text(
                        'Tap untuk tambah gambar',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Judul Resep',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: titleController,
            decoration: _inputDecoration('Judul resep kamu...'),
            onChanged: onTitleChanged,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Negara',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration(
                        'Negara',
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
                      icon: Icon(
                        HugeIcons.strokeRoundedArrowDown01,
                        size: 18,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Label',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Halal',
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              color: Colors.grey[500],
                            ),
                          ),
                          Switch(
                            value: isHalal,
                            activeColor: Colors.green[500],
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.grey[300],
                            onChanged: onHalalChanged,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Durasi',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: timeController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration('0').copyWith(
                        suffixText: 'Menit',
                        suffixStyle: GoogleFonts.poppins(
                          color: Colors.grey[500],
                          fontSize: 13.5,
                        ),
                      ),
                      onChanged: onTimeChanged,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Porsi',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: servingController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration('0').copyWith(
                        suffixText: 'Porsi',
                        suffixStyle: GoogleFonts.poppins(
                          color: Colors.grey[500],
                          fontSize: 13.5,
                        ),
                      ),
                      onChanged: onServingChanged,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
