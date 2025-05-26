import 'package:get_it/get_it.dart';
import 'package:spotifake/data/repository/auth/auth_repository_impl.dart';
import 'package:spotifake/data/repository/song/song_repository_impl.dart';
import 'package:spotifake/data/sources/auth/auth_firebase_service.dart';
import 'package:spotifake/data/sources/songs/song_firebase_service.dart';
import 'package:spotifake/domain/repository/auth/auth_repository.dart';
import 'package:spotifake/domain/repository/song/song_repository.dart';
import 'package:spotifake/domain/usecases/auth/signin_usecase.dart';
import 'package:spotifake/domain/usecases/auth/signup_usecase.dart';
import 'package:spotifake/domain/usecases/song/song_usecase.dart';

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

  sl.registerSingleton<SongRepository>(
    SongRepositoryImpl()
  );

  //* Usecases
  sl.registerSingleton<SignInUseCase>(
    SignInUseCase()
  );

  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase()
  );

  sl.registerSingleton<SongUsecase>(
    SongUsecase()
  );

}