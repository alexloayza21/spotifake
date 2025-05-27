import 'package:spotifake/core/usecase/usecase.dart';
import 'package:spotifake/domain/repository/song/songs_repository.dart';
import 'package:spotifake/services_locator.dart';

class IsFavoriteSongUsecase extends Usecase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongsRepository>().isFavoriteSong(params!);
  }
  
}