import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../favorite/bloc/favorite_bloc.dart';

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
          return Icon(
            state.isFavorite ? Icons.favorite : Icons.favorite_outline,
            color: state.isFavorite ? Colors.red : Colors.white,
          );
        },
      ),
    );
  }
}
