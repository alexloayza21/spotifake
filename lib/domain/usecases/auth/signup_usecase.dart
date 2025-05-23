import 'package:dartz/dartz.dart';
import 'package:spotifake/core/usecase/usecase.dart';
import 'package:spotifake/data/models/auth/create_user_req.dart';
import 'package:spotifake/domain/repository/auth/auth_repository.dart';
import 'package:spotifake/services_locator.dart';

class SignUpUseCase implements Usecase<Either, CreateUserReq>{
  @override
  Future<Either> call({CreateUserReq? params}) {
    return sl<AuthRepository>().signUp(params!);
  }
  
}