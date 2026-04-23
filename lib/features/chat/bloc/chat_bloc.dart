import '../../../core/imports/common_imports.dart';
import '../data/chat_repository.dart';
import '../models/message_model.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;

  ChatBloc(this._chatRepository) : super(ChatInitial()) {
    on<LoadMessagesEvent>((event, emit) async {
      AppLogger.i(
        "🚀 Bloc Event: LoadMessagesEvent for Product ID: ${event.productId}",
      );
      emit(ChatLoading());

      await emit.forEach<List<MessageModel>>(
        _chatRepository.getMessages(event.productId),
        onData: (messages) {
          AppLogger.d(
            "📥 Bloc Success: Received ${messages.length} messages from Stream",
          );
          return ChatLoaded(messages);
        },
        onError: (error, stackTrace) {
          AppLogger.e(
            "🔴 Bloc Error: Stream connection failed",
            error,
            stackTrace,
          );
          return ChatError(error.toString());
        },
      );
    });

    on<SendMessageEvent>((event, emit) async {
      AppLogger.i("📤 Bloc Event: SendMessageEvent -> Content: ${event.text}");

      try {
        await _chatRepository.sendMessage(event.text, "current_user_id");
        AppLogger.i("✅ Bloc Success: Message sent successfully");
      } catch (e, stackTrace) {
        AppLogger.e("❌ Bloc Error: Failed to send message", e, stackTrace);
      }
    });
  }
}
