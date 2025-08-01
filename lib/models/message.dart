import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  // how an individual message should look like
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });

  // method to convert to a map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail, //used receiverID here, NOTE
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
