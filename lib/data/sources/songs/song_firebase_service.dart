import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotifake/data/models/song/song_model.dart';
import 'package:spotifake/domain/entities/song/song_entity.dart';
import 'package:spotifake/domain/usecases/song/is_favorite_song_usecase.dart';
import 'package:spotifake/services_locator.dart';

abstract class SongFirebaseService {

  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
  
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
        bool isFavorite = await sl<IsFavoriteSongUsecase>().call(
          params: element.reference.id
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
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
        bool isFavorite = await sl<IsFavoriteSongUsecase>().call(
          params: element.reference.id
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs);

    } catch (e) {
      return Left(e.toString());
    }
  }
  
  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async{
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance; 

      late bool isFavorite;

      final user = auth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firestore.collection('Users')
      .doc(uId)
      .collection('FavoriteSongs')
      .where('songId', isEqualTo: songId)
      .get();

      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firestore.collection('Users')
          .doc(uId)
          .collection('FavoriteSongs')
          .add({'songId': songId, 'addedDate': Timestamp.now()});
        isFavorite = true;
      }

      return Right(isFavorite);

    } catch (e) {
      return Left(e.toString());
    }
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async{
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance; 

      final user = auth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firestore.collection('Users')
      .doc(uId)
      .collection('FavoriteSongs')
      .where('songId', isEqualTo: songId)
      .get();

      if (favoriteSongs.docs.isNotEmpty) {
        return true; // Song is already in favorites
      } else {
        return false; // Song is not in favorites
      }


    } catch (e) {
      throw false; // In case of error, return false
    }
  }
  
  @override
  Future<Either> getUserFavoriteSongs() async{
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance; 

      final user = auth.currentUser;
      String uId = user!.uid;

      List<SongEntity> favoriteSongs = [];

      QuerySnapshot favoritesSnapshot = await firestore
      .collection('Users')
      .doc(uId)
      .collection('FavoriteSongs')
      .get();

      for (var element in favoritesSnapshot.docs) {
        String songId = element['songId'];
        var song = await firestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorite = true;
        songModel.songId = songId;
        favoriteSongs.add(songModel.toEntity());
      }

      return Right(favoriteSongs);

    } catch (e) {
      return Left(e.toString());
    }
  }
  
}