import 'package:dartz/dartz.dart';
import 'package:spotifake/core/usecase/usecase.dart';
import 'package:spotifake/domain/repository/auth/auth_repository.dart';
import 'package:spotifake/services_locator.dart';

class UserUsecase implements Usecase<Either, dynamic>{
  @override
  Future<Either> call({params}) async{
    return await sl<AuthRepository>().getUser();
  }
  
}