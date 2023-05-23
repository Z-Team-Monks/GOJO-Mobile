import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorite_bloc.dart';




class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<FavoriteBloc>(context).add(
          FavoriteStatusChanged(),
        );
      },
      icon: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state.isFavorite) {
            return const Icon(
              Icons.favorite,
              color: Colors.red,
            );
          }
          return const Icon(
            Icons.favorite_outline,
            color: Colors.white,
          );
        },
      ),
    );
  }
}
