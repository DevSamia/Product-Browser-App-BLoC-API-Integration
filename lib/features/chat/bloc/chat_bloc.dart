import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_browser_app/features/chat/bloc/chat_event.dart';

import '../data/chat_service.dart';
import '../models/message_model.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService _chatService;

  ChatBloc(this._chatService) : super(ChatInitial()) {
    on<LoadMessagesEvent>((event, emit) async {
      emit(ChatLoading());
      await emit.forEach<List<MessageModel>>(
        _chatService.getMessages(event.productId),
        onData: (messages) => ChatLoaded(messages),
        onError: (error, stackTrace) => ChatError(error.toString()),
      );
    });

    on<SendMessageEvent>((event, emit) async {
      await _chatService.sendMessage(event.text, "current_user_id");
    });
  }
}
