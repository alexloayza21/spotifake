import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifake/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotifake/domain/usecases/song/add_or_remove_favorite_usecase.dart';
import 'package:spotifake/services_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState>  {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  void updateFavoriteButton(String songId) async{
    var result = await sl<AddOrRemoveFavoriteUsecase>().call(params: songId);

    result.fold(
      (left) {
        
      },
      (right) {
        emit(FavoriteButtonUpdated(isFavorite: right));
      },
    );
  }
  
}