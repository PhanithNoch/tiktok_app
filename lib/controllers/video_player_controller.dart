import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_app/models/video_model.dart';
import 'package:video_player/video_player.dart';

class HomeVideoPlayerController extends GetxController with StateMixin {
  final RxList<VideoModel> lstVideos = RxList<VideoModel>([]);
  final firebase = FirebaseFirestore.instance;

  @override
  onInit() async {
    super.onInit();
    lstVideos.bindStream(
        firebase.collection('videos').snapshots().map((QuerySnapshot query) {
      List<VideoModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(VideoModel.fromsnap(element));
      }
      return retVal;
    }));

    print('length of video ${lstVideos.length}');
  }

  @override
  void onReady() {
    super.onReady();
  }
}
