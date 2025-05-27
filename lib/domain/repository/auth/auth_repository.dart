import 'package:dartz/dartz.dart';
import 'package:spotifake/data/models/auth/create_user_req.dart';
import 'package:spotifake/data/models/auth/signin_user_req.dart';

abstract class AuthRepository {
  
  Future<Either> signIn(SigninUserReq signinUserReq);

  Future<Either> signUp(CreateUserReq createUserReq);

  Future<Either> getUser();
  
}