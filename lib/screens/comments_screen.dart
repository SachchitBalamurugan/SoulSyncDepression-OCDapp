import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CommentScreen extends StatefulWidget {
  final String postId;
  const CommentScreen({Key? key, required this.postId}) : super(key: key);

  @override
  CommentScreenState createState() => CommentScreenState();
}

class CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  final String? name = FirebaseAuth.instance.currentUser!.displayName;
  // Function to post a comment to Firestore
  Future<void> postComment() async {
    String commentText = _commentController.text.trim();
    if (commentText.isNotEmpty) {
      final CollectionReference commentsCollection =
          FirebaseFirestore.instance.collection('comments');
          Timestamp timestamp = Timestamp.now();

      await commentsCollection.doc(widget.postId).collection('comments').add({
        'commentText': commentText,
        'dateTime': timestamp,
        'name': name,
      });

      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('comments')
                  .doc(widget.postId)
                  .collection('comments')
                  .orderBy('dateTime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }else {
                  List<CommentSection> commentSections = snapshot.data!.docs
                      .map((doc) => CommentSection.fromSnapshot(doc))
                      .toList();
                      if(commentSections.isEmpty){
                        return const Center(child: Text("No Comments"));
                      }else{
                        return ListView.builder(
                    itemCount: commentSections.length,
                    itemBuilder: (context, index) {
                      CommentSection commentSection = commentSections[index];
                      return ListTile(
                        title: Text(commentSection.name),
                        subtitle: Text(commentSection.comments),
                        trailing: Text(
                            "${commentSection.time.toDate().toLocal()}".split(' ')[0]),
                      );
                    },
                  );
                      }
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(labelText: 'Enter your comment'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    postComment();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentSection{
  final String id;
  final String name;
  final Timestamp time;
  final String comments;

  CommentSection({required this.id, required this.time, required this.comments, required this.name});
  factory CommentSection.fromSnapshot(DocumentSnapshot snapshot) {
final map = snapshot.data() as Map<String, dynamic>;
final commentId = snapshot.id;
return CommentSection(
  id: commentId, 
time: map["dateTime"], 
comments: map["commentText"], 
name: map["name"]);
  }
}