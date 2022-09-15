import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_app/views/video_preview_screen.dart';
import 'dart:io';

class HomeController extends GetxController {
  pickVideo() async {
    try {
      final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (video != null) {
        Get.to(VideoPreviewScreen(
          videoPath: File(video.path),
        ));

        /// do action
      }
    } catch (e) {
      print('debug error : $e');
    }
  }
}
