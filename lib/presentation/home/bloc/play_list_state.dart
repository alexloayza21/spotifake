import 'package:spotifake/domain/entities/song/song_entity.dart';

abstract class PlayListState {}

class PlayListLoading extends PlayListState {}

class PlayListLoaded extends PlayListState {
  final List<SongEntity> songs;
  PlayListLoaded({required this.songs});
  
}

class PlayListLoadError extends PlayListState {}