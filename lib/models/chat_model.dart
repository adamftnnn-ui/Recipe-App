class ChatMessage {
  final String avatarUrl;
  final String name;
  final String? role;
  final String message;
  final String time;

  ChatMessage({
    required this.avatarUrl,
    required this.name,
    this.role,
    required this.message,
    required this.time,
  });
}
