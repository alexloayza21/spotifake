import 'package:dartz/dartz.dart';
import 'package:spotifake/data/sources/songs/song_firebase_service.dart';
import 'package:spotifake/domain/repository/song/song_repository.dart';
import 'package:spotifake/services_locator.dart';

class SongRepositoryImpl extends SongRepository {
  
  @override
  Future<Either> getNewsSongs() async{
    return await sl<SongFirebaseService>().getNewsSongs();
  }
  
}