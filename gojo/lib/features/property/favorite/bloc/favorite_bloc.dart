import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gojo/features/property/favorite/data/favorite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoritePropertyRepository favoritePropertyRepository;
  final String propertyId;
  FavoriteBloc({
    required this.favoritePropertyRepository,
    required this.propertyId,
  }) : super(const FavoriteState()) {
    on<LoadFavorite>((event, emit) {
      emit(state.copywith(isFavorite: event.isFavorite));
    });

    on<FavoriteStatusChanged>((event, emit) async {
      final isFavorite = !state.isFavorite;

      if (isFavorite) {
        _handleDeleteFavorite();
      } else {
        _handlePostFavorite();
      }
      emit(state.copywith(isFavorite: isFavorite));
    });
  }

  void _handleDeleteFavorite() async {
    try {
      await favoritePropertyRepository.unfavorProperty(propertyId);
    } catch (e) {
      // ignore
    }
  }

  void _handlePostFavorite() async {
    try {
      await favoritePropertyRepository.favorProperty(propertyId);
    } catch (e) {
      // ignore
    }
  }
}
