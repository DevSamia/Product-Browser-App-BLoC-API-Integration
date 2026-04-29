import '../../../core/imports/common_imports.dart';
import '../models/message_model.dart';

class ChatRepository {
  final ChatWebService chatWebService;
  ChatRepository(this.chatWebService);

  Stream<List<MessageModel>> getMessages(String productId) {
    AppLogger.i(
      "📦 Repository: Mapping messages stream for Product: $productId",
    );

    return chatWebService.getMessages(productId).map((snapshot) {
      try {
        final messages = snapshot.docs.map((doc) {
          return MessageModel.fromJson(doc.data());
        }).toList();
        AppLogger.d(
          "📥 Repository: Successfully mapped ${messages.length} messages",
        );
        return messages;
      } catch (e, stackTrace) {
        AppLogger.e(
          "❌ Repository Error: Failed to map chat messages",
          e,
          stackTrace,
        );
        return [];
      }
    });
  }

  Future<void> sendMessage(String text, String senderId) async {
    AppLogger.d("🚀 Repository: Sending message from user: $senderId");

    try {
      await chatWebService.sendMessage(text, senderId);
      AppLogger.i("✅ Repository: Message sent to WebService successfully");
    } catch (e, stackTrace) {
      AppLogger.e("❌ Repository Error: Failed to send message", e, stackTrace);
      throw Exception("Failed to send message: $e");
    }
  }
}
