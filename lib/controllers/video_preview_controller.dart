import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

class VideoPreviewController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  ///upload videos to firebase
  uploadVideo(String video, String caption) async {
    EasyLoading.show(status: 'loading...');
    String uid = FirebaseAuth.instance.currentUser!.uid;
    print('user id :${uid}');

    DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final docs = await FirebaseFirestore.instance.collection('videos').get();

    final length = docs.docs.length;
    final videoURL = await uploadToStorage("video $length", video);
    final thumbnailURL = await uploadThumbnail("video $length", video);

    Map<String, dynamic> data = {
      'caption': caption,
      'uid': uid,
      'likes': [],
      'comment': 0,
      'share': 0,
      'thumbnail': thumbnailURL,
      'videoURL': videoURL,
      'profile': (user.data() as Map)['profile']
      // 'profile':(documentSnapshot.data() as Map)['']
    };

    /// save to firebasefirestore
    await FirebaseFirestore.instance
        .collection('videos')
        .doc('video $length')
        .set(data);

    Get.snackbar("Message", "Video Uploaded");
    EasyLoading.dismiss();
  }

  compressVideo(String videoPath) async {
    final mediaInfo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return mediaInfo!.file;
  }

  uploadThumbnail(String uid, String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);

    Reference reference =
        FirebaseStorage.instance.ref().child('thumbnails').child(uid);
    final uploadTask = reference.putFile(thumbnail);

    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  uploadToStorage(String uid, String video) async {
    Reference reference =
        FirebaseStorage.instance.ref().child('videos').child(uid);
    final uploadTask = reference.putFile(await compressVideo(video));

    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
}
