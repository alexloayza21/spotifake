import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifake/common/helpers/is_dark_mode.dart';
import 'package:spotifake/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotifake/core/config/theme/app_colors.dart';
import 'package:spotifake/domain/entities/song/song_entity.dart';
import 'package:spotifake/presentation/home/bloc/play_list_cubit.dart';
import 'package:spotifake/presentation/home/bloc/play_list_state.dart';
import 'package:spotifake/presentation/song_player/pages/song_player.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayListCubit()..fetchPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PlayListLoaded) {
            return Column(
              spacing: 20,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Playlist', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    Text('See More', style: TextStyle(fontSize: 12))
                  ],
                ),
                _songs(state.songs),
              ],
            );
          } else if (state is PlayListLoadError) {
            return Center(child: Text('Error loading playlist: ${state.toString()}'));
          }
          return Container();
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      itemCount: songs.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final song = songs[index];
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SongPlayerPage(song: song))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 20,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.isDarkMode ? AppColors.darkGrey : Color(0xffE6E6E6),
                ),
                child: Icon(Icons.play_arrow_rounded, color: context.isDarkMode ? Color(0xFF959595) : Color(0xff555555))
              ),
          
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(song.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(song.artist, style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
          
              Text(song.duration.toString().replaceAll('.', ':'), style: TextStyle(fontSize: 15),),
              FavoriteButton(song: song)// Format duration
            ],
          ),
        );
      },
    );
  }
}
