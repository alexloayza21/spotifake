import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifake/common/helpers/is_dark_mode.dart';
import 'package:spotifake/common/widgets/appbar/app_bar.dart';
import 'package:spotifake/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotifake/presentation/profile/bloc/profile_info_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('Profile'),
        backgroundColor:
            IsDarkMode(context).isDarkMode ? Color(0xff2C2B2B) : Colors.white,
      ),
      body: Column(children: [_profileInfo(context)]),
    );
  }

  Widget _profileInfo(BuildContext context) {
    var colorText = IsDarkMode(context).isDarkMode ? Colors.white : Color(0xff222222);
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color:
              IsDarkMode(context).isDarkMode ? Color(0xff2C2B2B) : Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(66),
            bottomRight: Radius.circular(66),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading){
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfileInfoError) {
              return Center(child: Text('Theres was an error loading info, please try again'));
            } else if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(state.user.imgUrl!) 
                      )
                    ),
                  ),

                  Text(state.user.email ?? '', style: TextStyle(fontSize: 12, color: colorText)),
                  Text(state.user.fullName ?? '', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorText)),

                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
