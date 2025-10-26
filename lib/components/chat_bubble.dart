import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  final String avatar;
  final String name;
  final String? role;
  final String message;
  final String time;
  final bool isAssistant;

  const ChatBubble({
    super.key,
    required this.avatar,
    required this.name,
    this.role,
    required this.message,
    required this.time,
    required this.isAssistant,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: Radius.circular(isAssistant ? 0 : 16),
      bottomRight: Radius.circular(isAssistant ? 16 : 0),
    );

    return Row(
      mainAxisAlignment: isAssistant
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isAssistant ? Colors.white : const Color(0xFFDCF8C6),
              borderRadius: borderRadius,
              boxShadow: [
                if (isAssistant)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: avatar.isNotEmpty
                          ? AssetImage(avatar)
                          : null,
                      backgroundColor: Colors.grey[300],
                      child: avatar.isEmpty
                          ? const Icon(
                              Icons.person,
                              size: 16,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        name,
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (role != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          role!,
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            color: const Color(0xFF1E88E5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    time,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
