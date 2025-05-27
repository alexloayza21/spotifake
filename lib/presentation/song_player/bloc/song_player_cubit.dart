import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotifake/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  SongPlayerCubit(): super(SongPlayerLoading()){

    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
        updateSongPlayer();
      }
    });

    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        audioPlayer.seek(Duration.zero);
        audioPlayer.pause();
      }
    });

  }

  void updateSongPlayer() {
    emit(SongPlayerLoaded());
  }

  AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerError());
    }

  }

  void playOrPause() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }

}