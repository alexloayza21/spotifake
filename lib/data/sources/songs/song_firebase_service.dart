import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotifake/data/models/song/song_model.dart';
import 'package:spotifake/domain/entities/song/song_entity.dart';

abstract class SongFirebaseService {

  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  
}

class SongFirebaseServiceImpl implements SongFirebaseService {

  @override
  Future<Either> getNewsSongs() async{
    try {      
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();
  
      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }

      return Right(songs);

    } catch (e) {
      return Left(e.toString());
    }
  }
  
  @override
  Future<Either> getPlayList() async{
    try {      
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();
  
      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }

      return Right(songs);

    } catch (e) {
      return Left(e.toString());
    }
  }
  
}