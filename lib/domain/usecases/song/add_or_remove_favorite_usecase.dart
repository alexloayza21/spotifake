import 'package:dartz/dartz.dart';
import 'package:spotifake/core/usecase/usecase.dart';
import 'package:spotifake/domain/repository/song/songs_repository.dart';
import 'package:spotifake/services_locator.dart';

class AddOrRemoveFavoriteUsecase extends Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }
  
}