import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/chat_controller.dart';
import '../models/chat_model.dart';
import '../components/chat_bubble.dart';
import '../components/search_bar.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ChatController controller = ChatController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _inputController = TextEditingController();

  final String _userAvatar = 'assets/images/avatar.jpg';
  final String _assistantAvatar = 'assets/images/avatar_ai.jpg';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addInitialGreeting(_assistantAvatar, context);
      setState(() {});
      _scrollToBottom();
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      controller.addUserMessage(text, _userAvatar, 'Adam', context);
    });

    _inputController.clear();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        controller.addAssistantMessage(
          'Ini balasan AI.',
          _assistantAvatar,
          context,
        );
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Center(
                child: Text(
                  'Chat',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: controller.chats.length,
                itemBuilder: (context, index) {
                  final ChatMessage chat = controller.chats[index];
                  return ChatBubble(
                    avatar: chat.avatarUrl,
                    name: chat.name,
                    role: chat.role,
                    message: chat.message,
                    time: chat.time,
                    isAssistant: chat.role != null,
                  );
                },
              ),
            ),

            SearchBarr(
              enableNavigation: false,
              placeholder: 'Ketik pertanyaanmu disini...',
              controller: _inputController,
              onSubmitted: _sendMessage,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
