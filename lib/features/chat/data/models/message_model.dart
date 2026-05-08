import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/message.dart';

class MessageModel {
  factory MessageModel() => throw UnimplementedError();

  static Message fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      productId: data['productId'] ?? '',
      senderUsername: data['senderUsername'] ?? '',
      text: data['text'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  static Map<String, dynamic> toMap(Message message) {
    return {
      'productId': message.productId,
      'senderUsername': message.senderUsername,
      'text': message.text,
      'createdAt': Timestamp.fromDate(message.createdAt),
    };
  }
}
