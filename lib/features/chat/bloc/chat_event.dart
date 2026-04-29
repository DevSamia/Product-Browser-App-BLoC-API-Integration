abstract class ChatEvent {}

class LoadMessagesEvent extends ChatEvent {
  final String productId;
  LoadMessagesEvent(this.productId);
}

class SendMessageEvent extends ChatEvent {
  final String text;
  final String productId;
  SendMessageEvent(this.text, this.productId);
}
