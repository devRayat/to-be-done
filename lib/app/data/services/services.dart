library services;

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/duration_adapter.dart';
import '../models/models.dart';

part 'database_service.dart';

Future<void> initServices() async {
  await Future.wait([
    Get.putAsync(() => DatabaseService().init()),
  ]);
}
