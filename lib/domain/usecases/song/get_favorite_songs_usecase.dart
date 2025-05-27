import 'package:dartz/dartz.dart';
import 'package:spotifake/core/usecase/usecase.dart';
import 'package:spotifake/domain/repository/song/songs_repository.dart';
import 'package:spotifake/services_locator.dart';

class GetFavoriteSongsUsecase extends Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async{
    return await sl<SongsRepository>().getUserFavoriteSongs();
  }
  
}