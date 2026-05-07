class Message {
  final String id;
  final String productId;
  final String senderUsername;
  final String text;
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.productId,
    required this.senderUsername,
    required this.text,
    required this.createdAt,
  });
}
