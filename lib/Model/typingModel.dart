import 'package:cloud_firestore/cloud_firestore.dart';

class Typing{
  String? senderId;
  String? receiverId;
  bool? isTyping;

  Typing({this.senderId, this.receiverId, this.isTyping});
  Map<String,dynamic>toJson(){
    return{
      'senderId':senderId,
      'receiverId': receiverId,
      'isTyping': isTyping
    };
  }

  factory Typing.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Typing(
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      isTyping: data['isTyping']??'',
    );
  }
}