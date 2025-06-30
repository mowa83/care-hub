import 'package:dio/dio.dart';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/chat/services/chat_model.dart';
import 'package:graduation_project/screens/login/services/shared_login_prefs.dart';

class ChatService {
  final Dio _dio = Dio();
  ChatService() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers['Content-Type'] = 'application/json';
  }
  Future<void> init() async {
    final token = await SharedPrefsUtils.getAccess();
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<Map<String, dynamic>> startChat(int targetId) async {
    await init();
    try {
      final startChat = StartChat(id: targetId);
      final response = await _dio.post(
        '/chat/start/',
        data: startChat.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final startChatModel = StartChat.fromJson(response.data);
        final chatId = startChatModel.id;
        final targetName = startChatModel.otherUser?.name ?? 'Unknown';
        final targetImage = startChatModel.otherUser?.image ?? '';
        if (chatId != null) {
          return {
            'chatId': chatId,
            'targetId': targetId,
            'targetName': targetName,
            'targetImage': targetImage,
          };
        } else {
          throw Exception('No chat ID returned from server');
        }
      } else {
        throw Exception('Failed to start chat: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to start chat: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<HistoryChat>> fetchChatHistory(int chatId) async {
    await init();
    try {
      final response = await _dio.get('/chat/history/$chatId/');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => HistoryChat.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch chat history: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch chat history: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<SendChat> sendMessage(int chatId, String content) async {
    await init();
    try {
      final sendChat = SendChat(id: chatId, content: content);
      final response = await _dio.post(
        '/chat/send/',
        data: sendChat.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SendChat.fromJson(response.data);
      } else {
        throw Exception('Failed to send message: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to send message: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<ChatList>> fetchChatList() async {
    await init();
    try {
      final response = await _dio.get('/chat/list/');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ChatList.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch chat list: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch chat list: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
