import '../../../core/imports/common_imports.dart';
import '../data/chat_repository.dart';
import '../models/message_model.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;

  ChatBloc(this._chatRepository) : super(ChatInitial()) {
    on<LoadMessagesEvent>((event, emit) async {
      emit(ChatLoading());

      await emit.forEach<List<MessageModel>>(
        _chatRepository.getMessages(event.productId),
        onData: (messages) => ChatLoaded(messages),
        onError: (error, stackTrace) => ChatError(error.toString()),
      );
    });

    on<SendMessageEvent>((event, emit) async {
      await _chatRepository.sendMessage(event.text, "current_user_id");
    });
  }
}
