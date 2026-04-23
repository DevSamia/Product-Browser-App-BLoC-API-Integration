import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/imports/common_imports.dart';

class ChatWebService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String productId) {
    return _firestore
        .collection('chats')
        .where('productId', isEqualTo: productId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> sendMessage(String text, String senderId) async {
    try {
      await _firestore.collection('chats').add({
        'text': text,
        'senderId': senderId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error sending message: $e");
      }
    }
  }
}
