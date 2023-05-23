part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {}

class LoadFavorite extends FavoriteEvent {
  final bool isFavorite;

  LoadFavorite({
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [isFavorite];
}

class FavoriteStatusChanged extends FavoriteEvent {
  @override
  List<Object?> get props => [];
}
