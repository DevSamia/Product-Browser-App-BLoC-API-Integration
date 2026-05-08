import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/message.dart';

part 'chat_event.freezed.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.watchMessages(String productId) = WatchMessagesEvent;
  const factory ChatEvent.sendMessage(String text, String productId) =
      SendMessageEvent;
  const factory ChatEvent.messagesUpdated(List<Message> messages) =
      MessagesUpdatedEvent;
}
