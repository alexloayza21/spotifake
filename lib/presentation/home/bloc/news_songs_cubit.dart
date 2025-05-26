import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:spotifake/domain/usecases/song/news_songs_usecase.dart';
import 'package:spotifake/presentation/home/bloc/news_songs_state.dart';
import 'package:spotifake/services_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  
  NewsSongsCubit() : super(NewsSongsLoading()); // Initial state is loading

  Future<void> fetchNewsSongs() async {
    final result = await sl<NewsSongUsecase>().call();
    result.fold(
      (left) => emit(NewsSongsLoadError()),
      (right) => emit(NewsSongsLoaded(songs: right)),
    );
  }
  
}