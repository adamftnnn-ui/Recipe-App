import '../models/user_model.dart';

class ProfileRepository {
  Future<UserModel> fetchUserProfile() async {
    return UserModel(name: 'Adam', avatarUrl: 'https://example.com/avatar.jpg');
  }
}