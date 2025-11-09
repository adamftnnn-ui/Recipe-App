class ChatMessage {
  final String avatarUrl;
  final String name;
  final String? role;
  final String message;
  final String time;
  final bool isAssistant;

  ChatMessage({
    required this.avatarUrl,
    required this.name,
    this.role,
    required this.message,
    required this.time,
    required this.isAssistant,
  });
}
