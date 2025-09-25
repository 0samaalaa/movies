import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:movies/core/utils/token_manager.dart';
import '../../features/favorites/data/datasources/favorites_remote_data_source.dart';
import '../../features/favorites/data/repositories/favorites_repository_impl.dart';
import '../../features/favorites/domain/repositories/favorites_repository.dart';
import '../../features/favorites/domain/usecases/add_favorite.dart';
import '../../features/favorites/domain/usecases/get_favorites.dart';
import '../../features/favorites/domain/usecases/is_favorite.dart';
import '../../features/favorites/domain/usecases/remove_favorite.dart';

final sl = GetIt.instance;
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await TokenManager.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    return handler.next(options);
  }
}

Future<void> init() async {
  final dio = Dio(
    BaseOptions(baseUrl: "https://route-movie-apis.vercel.app/"),
  );
  dio.interceptors.add(AuthInterceptor());
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton<FavoritesRemoteSource>(
        () => FavoritesRemoteSource(sl()),
  );
  sl.registerLazySingleton<FavoritesRepository>(
        () => FavoritesRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetFavorites(sl()));
  sl.registerLazySingleton(() => AddFavorite(sl()));
  sl.registerLazySingleton(() => RemoveFavorite(sl()));
  sl.registerLazySingleton(() => IsFavorite(sl()));
}
