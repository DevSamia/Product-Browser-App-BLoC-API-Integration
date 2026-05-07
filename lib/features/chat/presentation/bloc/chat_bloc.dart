import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/message.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/watch_messages_usecase.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final WatchMessagesUseCase _watchMessagesUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final SharedPreferences _prefs;
  StreamSubscription? _messagesSubscription;

  ChatBloc({
    required WatchMessagesUseCase watchMessagesUseCase,
    required SendMessageUseCase sendMessageUseCase,
    required SharedPreferences prefs,
  }) : _watchMessagesUseCase = watchMessagesUseCase,
       _sendMessageUseCase = sendMessageUseCase,
       _prefs = prefs,
       super(ChatInitial()) {
    on<WatchMessagesEvent>(_onWatchMessages);
    on<MessagesUpdatedEvent>(_onMessagesUpdated);
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onWatchMessages(
    WatchMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());

    // تأكد من توليد اسم المستخدم فور فتح المحادثة إذا لم يكن موجوداً
    await _getOrGenerateUsername();

    await _messagesSubscription?.cancel();
    _messagesSubscription = _watchMessagesUseCase(event.productId).listen(
      (messages) => add(MessagesUpdatedEvent(messages)),
      onError: (error) => emit(ChatError(error.toString())),
    );
  }

  void _onMessagesUpdated(MessagesUpdatedEvent event, Emitter<ChatState> emit) {
    emit(ChatLoaded(List<Message>.from(event.messages)));
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    if (event.text.trim().isEmpty) return;

    final username = await _getOrGenerateUsername();
    try {
      await _sendMessageUseCase(
        productId: event.productId,
        senderUsername: username,
        text: event.text,
      );
    } catch (e) {
      // يمكن إضافة حالة خطأ هنا إذا لزم الأمر
    }
  }

  Future<String> _getOrGenerateUsername() async {
    String? username = _prefs.getString('chat_username');
    if (username == null || username.isEmpty) {
      username = 'User_${Random().nextInt(9000) + 1000}';
      await _prefs.setString('chat_username', username);
    }
    return username;
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
