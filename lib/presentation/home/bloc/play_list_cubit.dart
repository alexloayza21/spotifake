import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:spotifake/domain/usecases/song/play_list_usecase.dart';
import 'package:spotifake/presentation/home/bloc/play_list_state.dart';
import 'package:spotifake/services_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  
  PlayListCubit() : super(PlayListLoading()); // Initial state is loading

  Future<void> fetchPlayList() async {
    final result = await sl<PlayListUsecase>().call();
    result.fold(
      (left) => emit(PlayListLoadError()),
      (right) => emit(PlayListLoaded(songs: right)),
    );
  }
  
}