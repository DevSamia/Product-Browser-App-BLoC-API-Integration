import '../models/message_model.dart';
import 'chat_web_service.dart';

class ChatRepository {
  final ChatWebService chatWebService;
  ChatRepository(this.chatWebService);

  Stream<List<MessageModel>> getMessages(String productId) {
    return chatWebService.getMessages(productId).map((snapshot) {
      return snapshot.docs.map((doc) {
        return MessageModel.fromJson(doc.data());
      }).toList();
    });
  }

  Future<void> sendMessage(String text, String senderId) async {
    try {
      await chatWebService.sendMessage(text, senderId);
    } catch (e) {
      throw Exception("Failed to send message: $e");
    }
  }
}
