
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifake/domain/usecases/auth/user_usecase.dart';
import 'package:spotifake/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotifake/services_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {

    var user = await sl<UserUsecase>().call();

    user.fold(
      (l) {
        emit(ProfileInfoError());
      },
      (r) {
        emit(ProfileInfoLoaded(user: r));
      },
    );

  }
  
}