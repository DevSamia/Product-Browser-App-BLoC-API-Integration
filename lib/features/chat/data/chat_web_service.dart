import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/imports/common_imports.dart';

class ChatWebService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String productId) {
    AppLogger.i(
      "📡 Firebase: Starting messages stream for Product: $productId",
    );

    return _firestore
        .collection('chats')
        .where('productId', isEqualTo: productId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .handleError((error) {
          AppLogger.e(
            "❌ Firebase Stream Error: Failed to fetch messages",
            error,
          );
        });
  }

  Future<void> sendMessage(String text, String senderId) async {
    AppLogger.d(
      "📤 Firebase: Attempting to send message from Sender: $senderId",
    );

    try {
      await _firestore.collection('chats').add({
        'text': text,
        'senderId': senderId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      AppLogger.i("✅ Firebase: Message added to Firestore successfully");
    } catch (e, stackTrace) {
      AppLogger.e("❌ Firebase Error: Failed to add message", e, stackTrace);
      rethrow;
    }
  }
}
