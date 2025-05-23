import 'package:get_it/get_it.dart';
import 'package:spotifake/data/repository/auth/auth_repository_impl.dart';
import 'package:spotifake/data/sources/auth/auth_firebase_service.dart';
import 'package:spotifake/domain/repository/auth/auth_repository.dart';
import 'package:spotifake/domain/usecases/auth/signin_usecase.dart';
import 'package:spotifake/domain/usecases/auth/signup_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies() async {

  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase()
  );

  sl.registerSingleton<SignInUseCase>(
    SignInUseCase()
  );

}