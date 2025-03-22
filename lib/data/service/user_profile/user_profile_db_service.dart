import 'package:job_pilot/core/local_storage/app_storage.dart';
import 'package:job_pilot/data/models/user_model.dart';

import 'i_user_profile_db_service.dart';

class UserProfileDbService implements IUserProfileDbService {
  final AppStorage appStorage;
  UserProfileDbService({
    required this.appStorage,
  });

  final userProfileKey = 'userProfile';
  @override
  Future<void> deleteUserProfile() async {
    final box = appStorage.appBox;
    await box?.delete(userProfileKey);
  }

  @override
  UserProfile? getUserProfile() {
    final box = appStorage.appBox;
    final userProfileModel = box?.get(userProfileKey) as String?;
    if (userProfileModel != null) {
      return UserProfile.fromJson(userProfileModel);
    } else {
      return null;
    }
  }

  @override
  Future<void> saveUserProfile({required UserProfile userProfile}) async {
    final box = appStorage.appBox;
    await box?.put(userProfileKey, userProfile.toJson());
  }
}
