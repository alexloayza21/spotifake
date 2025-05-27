import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifake/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotifake/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotifake/core/config/theme/app_colors.dart';
import 'package:spotifake/domain/entities/song/song_entity.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.song, this.size = 25});
  final SongEntity song;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(), 
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          var cubit = context.read<FavoriteButtonCubit>();
          if (state is FavoriteButtonInitial) {
            return IconButton(
              onPressed: () => cubit.updateFavoriteButton(song.songId), 
              icon: Icon(
              song.isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: AppColors.darkGrey,
              size: size,
              )
            );
          } else if (state is FavoriteButtonUpdated) {
            return IconButton(
              onPressed: () => cubit.updateFavoriteButton(song.songId), 
              icon: Icon(
              state.isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: AppColors.darkGrey,
              size: size,
              )
            );
          }
          return Container();
        },
      )
    );
  }
}
