import '../entities/message.dart';

abstract class ChatRepository {
  Stream<List<Message>> watchMessages(String productId);
  Future<void> sendMessage({
    required String productId,
    required String senderUsername,
    required String text,
  });
}
