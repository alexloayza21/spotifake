
abstract class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {
  // final SongEntity song;

  // SongPlayerLoaded(this.song);
}

class SongPlayerError extends SongPlayerState {}
