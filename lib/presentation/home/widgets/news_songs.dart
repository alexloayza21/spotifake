import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifake/common/helpers/is_dark_mode.dart';
import 'package:spotifake/core/config/constants/app_urls.dart';
import 'package:spotifake/core/config/theme/app_colors.dart';
import 'package:spotifake/domain/entities/song/song_entity.dart';
import 'package:spotifake/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotifake/presentation/home/bloc/news_songs_state.dart';
import 'package:spotifake/presentation/song_player/pages/song_player.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsSongsCubit()..fetchNewsSongs(), 
      child: SizedBox(
        height: 300,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsSongsLoaded) {
              return _songs(state.songs);
            } else if (state is NewsSongsLoadError) {
              return Center(child: Text(state.toString()));
            }
            return Container();
          },
        ),
      )
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      itemCount: songs.length, 
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => SizedBox(width: 10),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SongPlayerPage(song: songs[index],))),
          child: SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: NetworkImage(
                          songs[index].artist.contains('Harris')
                          ?'${AppUrls.coverFirestorage}${songs[index].artist.replaceAll(',', '%2C')}%20%20-%20${songs[index].title}.jpg?${AppUrls.media}'
                          : '${AppUrls.coverFirestorage}${songs[index].artist} - ${songs[index].title}.jpg?${AppUrls.media}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 40,
                        width: 40,
                        transform: Matrix4.translationValues(10, 18, 0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.isDarkMode ? AppColors.darkGrey : Color(0xffE6E6E6),
                        ),
                        child: Icon(Icons.play_arrow_rounded, color: context.isDarkMode ? Color(0xFF959595) : Color(0xff555555))
                      ),
                    ),
                  ),
                ),
          
                SizedBox(height: 10),
                Text(
                  songs[index].title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
          
                SizedBox(height: 10),
                Text(
                  songs[index].artist,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

