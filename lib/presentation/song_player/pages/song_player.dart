import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifake/common/widgets/appbar/app_bar.dart';
import 'package:spotifake/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotifake/core/config/constants/app_urls.dart';
import 'package:spotifake/core/config/theme/app_colors.dart';
import 'package:spotifake/domain/entities/song/song_entity.dart';
import 'package:spotifake/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotifake/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget {
  const SongPlayerPage({super.key, required this.song});
  final SongEntity song;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text(
          'Now playing',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => SongPlayerCubit()..loadSong(
          '${AppUrls.songFirestorage}${song.artist} - ${song.title}.mp3?${AppUrls.media}',
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            spacing: 20,
            children: [
              _songCover(context), 
              _songDetails(),
              _songPlayer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: NetworkImage(
            song.artist.contains('Harris')
                ? '${AppUrls.coverFirestorage}${song.artist.replaceAll(',', '%2C')}%20%20-%20${song.title}.jpg?${AppUrls.media}'
                : '${AppUrls.coverFirestorage}${song.artist} - ${song.title}.jpg?${AppUrls.media}',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _songDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              song.artist,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),

        FavoriteButton(song: song, size: 35)
      ],
    );
  }

  Widget _songPlayer() {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        var cubit = context.read<SongPlayerCubit>();
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: cubit.songPosition.inSeconds.toDouble(),
                min: 0.0,
                max: cubit.songDuration.inSeconds.toDouble(), 
                onChanged: (value) {
                  
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    formatDuration(cubit.songPosition),
                    style: TextStyle(fontSize: 15),
                  ),

                  Text(
                    formatDuration(cubit.songDuration),
                    style: TextStyle(fontSize: 15),
                  ),

                ],
              ),

              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: IconButton(
                  icon: Icon(
                    cubit.audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => cubit.playOrPause(),
                ),
              )

            ],
          );
        } else if (state is SongPlayerError) {
          return Text('Error loading song');
        } else if (state is SongPlayerLoading) {
          return CircularProgressIndicator();
        }
        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

}
