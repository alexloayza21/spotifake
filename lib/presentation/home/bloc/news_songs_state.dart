import 'package:spotifake/domain/entities/song/song_entity.dart';

abstract class NewsSongsState {}

class NewsSongsLoading extends NewsSongsState {}

class NewsSongsLoaded extends NewsSongsState {
  final List<SongEntity> songs;
  NewsSongsLoaded({required this.songs});
  
}

class NewsSongsLoadError extends NewsSongsState {}