abstract class ProfileRepository {
  Future<Map<String, dynamic>> getProfile();
  Future<void> updateProfile(String name, String phone, int avatarId);
  Future<void> deleteAccount();
  Future<String> resetPassword(String oldPassword, String newPassword);
}
