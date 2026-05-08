import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../models/message_model.dart';

class FirestoreChatRepository implements ChatRepository {
  final FirebaseFirestore _firestore;

  FirestoreChatRepository(this._firestore);

  @override
  Stream<List<Message>> watchMessages(String productId) {
    return _firestore
        .collection('chats')
        .doc(productId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => MessageModel.fromFirestore(doc))
              .toList();
        });
  }

  @override
  Future<void> sendMessage({
    required String productId,
    required String senderUsername,
    required String text,
  }) async {
    final docRef = _firestore
        .collection('chats')
        .doc(productId)
        .collection('messages')
        .doc();

    final message = Message(
      id: docRef.id,
      productId: productId,
      senderUsername: senderUsername,
      text: text,
      createdAt: DateTime.now(),
    );

    await docRef.set(MessageModel.toMap(message));
  }
}
