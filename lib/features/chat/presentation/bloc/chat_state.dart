import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/message.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.initial() = ChatInitial;
  const factory ChatState.loading() = ChatLoading;
  const factory ChatState.loaded(List<Message> messages) = ChatLoaded;
  const factory ChatState.error(String message) = ChatError;
}
