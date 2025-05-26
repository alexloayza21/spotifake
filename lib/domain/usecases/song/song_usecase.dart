import 'package:dartz/dartz.dart';
import 'package:spotifake/core/usecase/usecase.dart';
import 'package:spotifake/data/repository/song/song_repository_impl.dart';
import 'package:spotifake/services_locator.dart';

class SongUsecase extends Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async{
    return await sl<SongRepositoryImpl>().getNewsSongs();
  }
  
}