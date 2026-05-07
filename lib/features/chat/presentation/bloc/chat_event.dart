import 'package:flutter/foundation.dart';
import '../../domain/entities/message.dart';

@immutable
abstract class ChatEvent {
  const ChatEvent();
}

class WatchMessagesEvent extends ChatEvent {
  final String productId;
  const WatchMessagesEvent(this.productId);
}

class SendMessageEvent extends ChatEvent {
  final String text;
  final String productId;
  const SendMessageEvent(this.text, this.productId);
}

class MessagesUpdatedEvent extends ChatEvent {
  final List<Message> messages;
  const MessagesUpdatedEvent(this.messages);
}
