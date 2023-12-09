// profile_controller.dart

import 'package:rentease_kb/models/user_model.dart';

class ProfileController {
  UserModel? _currentUser;

  Future<void> fetchUserData(String userID) async {
    _currentUser = await UserModel.getUserData(userID);
  }

  UserModel? get currentUser => _currentUser;
}
