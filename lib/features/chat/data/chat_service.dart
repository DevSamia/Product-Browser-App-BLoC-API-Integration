import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/imports/common_imports.dart';
import '../models/message_model.dart'; // تأكدي من صحة المسار لملف الـ Model

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<MessageModel>> getMessages() {
    return _firestore
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return MessageModel.fromMap(doc.data());
      }).toList();
    });
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