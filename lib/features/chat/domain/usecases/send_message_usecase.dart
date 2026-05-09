import '../repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<void> call({
    required String productId,
    required String senderUsername,
    required String text,
  }) async {
    if (text.trim().isEmpty) {
      throw Exception('Message text cannot be empty');
    }
    return repository.sendMessage(
      productId: productId,
      senderUsername: senderUsername,
      text: text,
    );
  }
}
