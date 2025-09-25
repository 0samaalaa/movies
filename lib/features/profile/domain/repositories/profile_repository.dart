abstract class ProfileRepository {
  Future<Map<String, dynamic>> getProfile();
  Future<void> updateProfile(String name, String phone, int avatarId);
  Future<void> deleteAccount();
  Future<String> resetPassword(String oldPassword, String newPassword);
  Future<List<Map<String, dynamic>>> getWatchlistFromApi();
  List<Map<String, dynamic>> getHistoryMovies();
  Future<void> addMovieToHistory(Map<String, dynamic> movie);
  Future<void> clearHistory();
  List<Map<String, dynamic>> getWatchlistMovies();
  Future<void> addMovieToWatchlist(Map<String, dynamic> movie);
  Future<void> removeMovieFromWatchlist(int movieId);
  Future<void> clearWatchlist();
}
