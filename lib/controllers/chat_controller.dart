import 'package:flutter/material.dart';
import '../models/chat_model.dart';

class ChatController {
  List<ChatMessage> chats = [];

  void addUserMessage(
    String text,
    String avatar,
    String name,
    BuildContext context,
  ) {
    chats.add(
      ChatMessage(
        avatarUrl: avatar,
        name: name,
        message: text,
        role: null,
        time: TimeOfDay.now().format(context),
      ),
    );
  }

  void addAssistantMessage(String text, String avatar, BuildContext context) {
    chats.add(
      ChatMessage(
        avatarUrl: avatar,
        name: 'Kama',
        role: 'Assistant',
        message: text,
        time: TimeOfDay.now().format(context),
      ),
    );
  }

  void addInitialGreeting(String avatar, BuildContext context) {
    chats.add(
      ChatMessage(
        avatarUrl: avatar,
        name: 'Kama',
        role: 'Assistant',
        message: 'Halo Adam, Apa yang bisa saya bantu?',
        time: TimeOfDay.now().format(context),
      ),
    );
  }
}
