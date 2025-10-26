import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller;
  const ProfileView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final user = controller.user;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Center(
                child: Text(
                  'Profil',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // BOX PROFIL
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDFDFE),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // FOTO
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: (user['avatarUrl'] as String?)?.isNotEmpty == true
                          ? Image.asset(
                              user['avatarUrl'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 80,
                              height: 80,
                              color: const Color(0xFFF2F3F5),
                              alignment: Alignment.center,
                              child: Text(
                                'No Image',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(width: 12),

                    // INFO
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // NAMA + EDIT
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user['name'] ?? '-',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    user['country'] ?? '-',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F5E9),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Center(
                                  child: Icon(
                                    HugeIcons.strokeRoundedEdit01,
                                    color: Color(0xFF43A047),
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // GENDER + UPLOADS + SHARE
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    HugeIcons.strokeRoundedMan,
                                    size: 14,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    user['gender'] ?? '-',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              Row(
                                children: [
                                  Icon(
                                    HugeIcons.strokeRoundedUploadCircle01,
                                    size: 14,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${user['uploads'] ?? 0} Posting',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Icon(
                                HugeIcons.strokeRoundedShare01,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // PERSONALSASI
              _buildSectionTitle('Personalisasi'),
              const SizedBox(height: 8),
              _buildMenuCard([
                {'icon': HugeIcons.strokeRoundedRiceBowl01, 'title': 'Resepku'},
                {
                  'icon': HugeIcons.strokeRoundedBookmark01,
                  'title': 'Simpanan',
                },
                {'icon': HugeIcons.strokeRoundedStar, 'title': 'Penilaian'},
              ]),

              const SizedBox(height: 20),

              // PENGATURAN
              _buildSectionTitle('Pengaturan'),
              const SizedBox(height: 8),
              _buildMenuCard([
                {'icon': HugeIcons.strokeRoundedProfile, 'title': 'Akun'},
                {'icon': HugeIcons.strokeRoundedEarth, 'title': 'Bahasa'},
                {
                  'icon': HugeIcons.strokeRoundedNotification01,
                  'title': 'Notifikasi',
                },
                {'icon': HugeIcons.strokeRoundedMoon01, 'title': 'Mode Gelap'},
              ]),

              const SizedBox(height: 20),

              // BANTUAN
              _buildSectionTitle('Bantuan'),
              const SizedBox(height: 8),
              _buildMenuCard([
                {
                  'icon': HugeIcons.strokeRoundedHelpCircle,
                  'title': 'Pusat Bantuan',
                },
              ]),

              const SizedBox(height: 20),

              // KELUAR
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Icon(
                        HugeIcons.strokeRoundedLogout01,
                        size: 24,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Keluar',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildMenuCard(List<Map<String, dynamic>> items) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFE),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Column(
            children: [
              ListTile(
                leading: Icon(item['icon'], size: 20, color: Colors.grey[700]),
                title: Text(
                  item['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey,
                ),
                onTap: () {},
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              if (index != items.length - 1)
                const Divider(height: 1, indent: 12, endIndent: 12),
            ],
          );
        }),
      ),
    );
  }
}
