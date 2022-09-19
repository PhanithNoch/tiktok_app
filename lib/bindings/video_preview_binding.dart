import 'package:get/get.dart';
import 'package:tiktok_app/controllers/video_preview_controller.dart';

class VideoPreviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoPreviewController>(() => VideoPreviewController());
  }
}
