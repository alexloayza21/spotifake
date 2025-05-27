import 'package:get_it/get_it.dart';
import 'package:spotifake/data/repository/auth/auth_repository_impl.dart';
import 'package:spotifake/data/repository/song/song_repository_impl.dart';
import 'package:spotifake/data/sources/auth/auth_firebase_service.dart';
import 'package:spotifake/data/sources/songs/song_firebase_service.dart';
import 'package:spotifake/domain/repository/auth/auth_repository.dart';
import 'package:spotifake/domain/repository/song/songs_repository.dart';
import 'package:spotifake/domain/usecases/auth/signin_usecase.dart';
import 'package:spotifake/domain/usecases/auth/signup_usecase.dart';
import 'package:spotifake/domain/usecases/auth/user_usecase.dart';
import 'package:spotifake/domain/usecases/song/add_or_remove_favorite_usecase.dart';
import 'package:spotifake/domain/usecases/song/get_favorite_songs_usecase.dart';
import 'package:spotifake/domain/usecases/song/is_favorite_song_usecase.dart';
import 'package:spotifake/domain/usecases/song/news_songs_usecase.dart';
import 'package:spotifake/domain/usecases/song/play_list_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies() async {

  //* Services
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<SongFirebaseService>(
    SongFirebaseServiceImpl()
  );

  //* Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  sl.registerSingleton<SongsRepository>(
    SongRepositoryImpl()
  );

  //* Usecases
  sl.registerSingleton<SignUpUseCase>(
   SignUpUseCase()
  );

  sl.registerSingleton<SignInUseCase>(
    SignInUseCase()
  );

  sl.registerSingleton<NewsSongUsecase>(
    NewsSongUsecase()
  );

  sl.registerSingleton<PlayListUsecase>(
    PlayListUsecase()
  );

  sl.registerSingleton<AddOrRemoveFavoriteUsecase>(
    AddOrRemoveFavoriteUsecase()
  );

  sl.registerSingleton<IsFavoriteSongUsecase>(
    IsFavoriteSongUsecase()
  );

  sl.registerSingleton<UserUsecase>(
    UserUsecase()
  );

  sl.registerSingleton<GetFavoriteSongsUsecase>(
    GetFavoriteSongsUsecase()
  );

}