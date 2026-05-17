import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class WatchMessagesUseCase {
  final ChatRepository repository;

  WatchMessagesUseCase(this.repository);

  Stream<List<Message>> call(String productId) {
    return repository.watchMessages(productId);
  }
}
