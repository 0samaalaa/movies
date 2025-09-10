import '../resources/app_images.dart';

class AvatarHelper {
  static String getAvatarAsset(int? id) {
    switch (id) {
      case 1:
        return MImages.avatar1;
      case 2:
        return MImages.avatar2;
      case 3:
        return MImages.avatar3;
      case 4:
        return MImages.avatar4;
      case 5:
        return MImages.avatar5;
      case 6:
        return MImages.avatar6;
      case 7:
        return MImages.avatar7;
      case 8:
        return MImages.avatar8;
      case 9:
        return MImages.avatar9;
      default:
        return MImages.avatar1;
    }
  }

  static List<String> get allAvatars => [
    MImages.avatar1,
    MImages.avatar2,
    MImages.avatar3,
    MImages.avatar4,
    MImages.avatar5,
    MImages.avatar6,
    MImages.avatar7,
    MImages.avatar8,
    MImages.avatar9,
  ];
}
