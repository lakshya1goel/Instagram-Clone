import 'package:cloud_firestore/cloud_firestore.dart';

// Function to get the timestamp of the last message in a chat room
Future<Timestamp?> getLastMessageTime(String chatRoomId) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("messages")
        .where("chatRoomId", isEqualTo: chatRoomId)
        .orderBy("createdOn", descending: true)
        .limit(1) // Limit to only retrieve the latest message
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Return the timestamp of the latest message
      final latestMessage = querySnapshot.docs.first.data() as Map<String, dynamic>;
      return latestMessage["createdOn"] as Timestamp;
    } else {
      // No messages found in the chat room
      return null;
    }
  } catch (e) {
    print("Error getting last message time: $e");
    return null;
  }
}
