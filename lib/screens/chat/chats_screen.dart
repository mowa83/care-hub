import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/chat/services/chat_model.dart';
import 'package:graduation_project/screens/chat/services/chat_services.dart';
import 'package:graduation_project/screens/chat/widgets/app_contact_card.dart';
import 'package:graduation_project/widgets/app_text.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late Future<List<ChatList>> _chatListFuture;
  final TextEditingController _searchController = TextEditingController();
  List<ChatList> _filteredChats = [];

  @override
  void initState() {
    super.initState();
    _chatListFuture = ChatService().fetchChatList();
    _searchController.addListener(_filterChats);
  }

  void _filterChats() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _chatListFuture.then((chats) {
        _filteredChats = chats.where((chat) {
          final name = chat.otherUser?.name?.toLowerCase() ?? '';
          final message = chat.lastMessage?.content?.toLowerCase() ?? '';
          return name.contains(query) || message.contains(query);
        }).toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Center(
                child: AppText(
                  title: 'Chats',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 36),
              TextFormField(
                controller: _searchController,
                cursorColor: AppColors.primary,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 246, 246, 246),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      Icons.search,
                      size: 25,
                      color: AppColors.grey,
                    ),
                  ),
                  hintText: 'Search Chats ...',
                  hintStyle: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  enabledBorder: getBorder(color: Colors.transparent),
                  focusedBorder: getBorder(color: AppColors.primary),
                  errorBorder: getBorder(color: AppColors.red),
                  focusedErrorBorder: getBorder(color: AppColors.red),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<List<ChatList>>(
                  future: _chatListFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError || !snapshot.hasData) {
                      return const Center(child: Text('Failed to load chats'));
                    }
                    final chats = _searchController.text.isEmpty
                        ? snapshot.data!
                        : _filteredChats;

                    if (chats.isEmpty) {
                      return const Center(child: Text('No chats available'));
                    }
                    return ListView.builder(
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        return Column(
                          children: [
                            AppContactCard(
                              photo: chat.otherUser?.image ?? '',
                              label: chat.otherUser?.name ?? '',
                              lastMessage: chat.lastMessage?.content ?? '',
                              timestamp: chat.lastMessage?.timestamp ?? '',
                              chatId: chat.id ?? 0,
                              targetId: chat.otherUser?.id ?? 0,
                              targetName: chat.otherUser?.name ?? '',
                              targetImage: chat.otherUser?.image ?? '',
                            ),
                            const SizedBox(height: 25),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder getBorder({required Color color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color),
  );
}
