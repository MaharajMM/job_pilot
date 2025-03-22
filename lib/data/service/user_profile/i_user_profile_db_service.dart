import 'package:job_pilot/data/models/user_model.dart';

abstract class IUserProfileDbService {
  Future<void> saveUserProfile({required UserProfile userProfile});
  Future<void> deleteUserProfile();
  UserProfile? getUserProfile();
}
