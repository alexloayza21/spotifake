import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifake/common/helpers/is_dark_mode.dart';
import 'package:spotifake/common/widgets/appbar/app_bar.dart';
import 'package:spotifake/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotifake/core/config/constants/app_urls.dart';
import 'package:spotifake/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:spotifake/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotifake/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotifake/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotifake/presentation/song_player/pages/song_player.dart';

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
      body: Column(
        children: [
          _profileInfo(context), 
          _favoriteSong()
        ]
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    var colorText =
        IsDarkMode(context).isDarkMode ? Colors.white : Color(0xff222222);
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
            if (state is ProfileInfoLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfileInfoError) {
              return Center(
                child: Text(
                  'Theres was an error loading info, please try again',
                ),
              );
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
                        image: NetworkImage(state.user.imgUrl!),
                      ),
                    ),
                  ),

                  Text(
                    state.user.email ?? '',
                    style: TextStyle(fontSize: 12, color: colorText),
                  ),
                  Text(
                    state.user.fullName ?? '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorText,
                    ),
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSong() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..fetchFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Text('FAVORITE SONGS'),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is FavoriteSongsError){
                  return Center(child: Text('data not found'));
                } else if (state is FavoriteSongsLoaded) {
                  return ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(height: 15,), 
                    itemCount: state.favoriteSongs.length,
                    itemBuilder: (context, index) {

                      var song = state.favoriteSongs[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SongPlayerPage(song: song))),
                        child: Row(
                          spacing: 20,
                          children: [
                            Container(
                              height: 70, 
                              width: 70, 
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    song.artist.contains('Harris')
                                    ?'${AppUrls.coverFirestorage}${song.artist.replaceAll(',', '%2C')}%20%20-%20${song.title}.jpg?${AppUrls.media}'
                                    : '${AppUrls.coverFirestorage}${song.artist} - ${song.title}.jpg?${AppUrls.media}',),
                                  fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.circular(14)
                              ),
                            ),
                        
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(song.artist, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  Text(song.title, style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                        
                            Text(song.duration.toString().replaceAll('.', ':'), style: TextStyle(fontSize: 15)),
                            FavoriteButton(
                              song: song,
                              key: UniqueKey(),
                              function: () => context.read<FavoriteSongsCubit>().removeSong(index),
                            )
                          ],
                        ),
                      );
                    }, 
                  );
                }
        
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
