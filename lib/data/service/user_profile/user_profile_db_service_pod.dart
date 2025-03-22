import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/core/local_storage/app_storage_pod.dart';
import 'package:job_pilot/data/service/user_profile/user_profile_db_service.dart';

final userProfileDbProvider = Provider.autoDispose<UserProfileDbService>(
  (ref) {
    return UserProfileDbService(appStorage: ref.watch(appStorageProvider));
  },
);
