import 'package:dartz/dartz.dart';
import 'package:spotifake/core/usecase/usecase.dart';
import 'package:spotifake/data/models/auth/signin_user_req.dart';
import 'package:spotifake/domain/repository/auth/auth_repository.dart';
import 'package:spotifake/services_locator.dart';

class SignInUseCase implements Usecase<Either, SigninUserReq> {
  // final AuthRepository _authRepository;

  // SignInUseCase(this._authRepository);

  @override
  Future<Either> call({SigninUserReq? params}) {
    return sl<AuthRepository>().signIn(params!);
  }
  
}