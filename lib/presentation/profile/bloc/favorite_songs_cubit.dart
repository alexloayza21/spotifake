import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifake/domain/entities/song/song_entity.dart';
import 'package:spotifake/domain/usecases/song/get_favorite_songs_usecase.dart';
import 'package:spotifake/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotifake/services_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongs = [];

  Future<void> fetchFavoriteSongs() async{
    var result = await sl<GetFavoriteSongsUsecase>().call();

    result.fold(
      (l) {
        emit(FavoriteSongsError());
      }, 
      (r) {
        favoriteSongs = r; // just to show
        emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
      },
    );
  }

  void removeSong(int index) {
    favoriteSongs.removeAt(index);
    emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
  }
  
}