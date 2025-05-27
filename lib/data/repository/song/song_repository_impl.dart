import 'package:dartz/dartz.dart';
import 'package:spotifake/data/sources/songs/song_firebase_service.dart';
import 'package:spotifake/domain/repository/song/songs_repository.dart';
import 'package:spotifake/services_locator.dart';

class SongRepositoryImpl extends SongsRepository {
  
  @override
  Future<Either> getNewsSongs() async{
    return await sl<SongFirebaseService>().getNewsSongs();
  }
  
  @override
  Future<Either> getPlayList() async{
    return await sl<SongFirebaseService>().getPlayList();
  }
  
  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSongs(songId);
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async{
    return await sl<SongFirebaseService>().isFavoriteSong(songId);
  }
  
  @override
  Future<Either> getUserFavoriteSongs() async{
    return await sl<SongFirebaseService>().getUserFavoriteSongs();
  }
  
}