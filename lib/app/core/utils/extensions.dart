part of utils;

extension PercentSize on double {
  double get height => Get.height * this / 100;
  double get width => Get.width * this / 100;
}
