import 'package:dartz/dartz.dart';
import 'package:spotifake/data/models/auth/create_user_req.dart';
import 'package:spotifake/data/models/auth/signin_user_req.dart';
import 'package:spotifake/data/sources/auth/auth_firebase_service.dart';
import 'package:spotifake/domain/repository/auth/auth_repository.dart';
import 'package:spotifake/services_locator.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either> signIn(SigninUserReq signinUserReq) async{
    return sl<AuthFirebaseService>().signIn(signinUserReq);
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async{
    return await sl<AuthFirebaseService>().signUp(createUserReq);
  }
  
  @override
  Future<Either> getUser() async{
    return await sl<AuthFirebaseService>().getUser();
  }
  
}