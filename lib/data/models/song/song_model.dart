import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotifake/domain/entities/song/song_entity.dart';

class SongModel {

  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;
  bool? isFavorite;
  String? songId;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
    required this.songId,
  });

  SongModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    artist = json['artist'];
    duration = json['duration'];
    releaseDate = json['releaseDate'];
  }
  
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title ?? '', 
      artist: artist ?? '', 
      duration: duration ?? 0, 
      releaseDate: releaseDate ?? Timestamp.now(),
      isFavorite: isFavorite ?? false,
      songId: songId ?? '',
    );
  }
}