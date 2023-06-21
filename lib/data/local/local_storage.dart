import 'hive/user_details.dart';

abstract class LocalStorage {
  Future<User?> getUserDetails();
  Future<void> addUserDetails(User user);
}
