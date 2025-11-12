import '../models/user_model.dart';

class UserRepository {
  Future<UserModel> fetchUser() async {
    return UserModel(name: 'Adam', avatarUrl: 'https://example.com/avatar.jpg');
  }
}
