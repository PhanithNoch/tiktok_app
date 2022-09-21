import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoURL;
  String thumbnail;
  String profilePhoto;

  VideoModel(
      {required this.username,
      required this.uid,
      required this.id,
      required this.likes,
      required this.commentCount,
      required this.shareCount,
      required this.songName,
      required this.caption,
      required this.videoURL,
      required this.thumbnail,
      required this.profilePhoto});

  static VideoModel fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return VideoModel(
      // username: snapshot['username'],
      username: '',
      uid: snapshot['uid'],
      id: '',
      likes: snapshot['likes'],
      commentCount: 0,
      shareCount: 0,
      songName: '',
      caption: snapshot['caption'],
      videoURL: snapshot['videoURL'],
      thumbnail: snapshot['thumbnail'],
      profilePhoto: '',
    );
  }
}
