import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ig_clone/models/post.dart';
import 'package:ig_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String caption, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Some error occured";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();

      Post post = Post(
          caption: caption,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now().toString(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);

      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
