part of 'favorite_bloc.dart';

enum FavoriteStatus { loading, success, error }

class FavoriteState extends Equatable {
  final bool isFavorite;
  final FavoriteStatus status;

  const FavoriteState({
    this.isFavorite = false,
    this.status = FavoriteStatus.loading,
  });

  FavoriteState copywith({
    bool? isFavorite,
    FavoriteStatus? status,
  }) {
    return FavoriteState(
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [isFavorite, status];
}
