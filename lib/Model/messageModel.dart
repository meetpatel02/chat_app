import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? senderId;
  String? receiverId;
  String? message;
  Timestamp? timestamp;
  bool? read;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.message,
    this.timestamp,
    this.read,
  });



  Map<String,dynamic>toJson(){
    return{
      'senderId':senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'read': read,
    };
}

  factory MessageModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return MessageModel(
      message: data['message']??'',
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      timestamp: data['timestamp'] ?? '',
      read: data['read'] ?? '',
    );
  }

}
