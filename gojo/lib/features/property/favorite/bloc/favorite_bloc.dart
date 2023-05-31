import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../detail/data/repository/detail_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final PropertyDetailRepository propertyDetailRepository;
  final int propertyId;
  FavoriteBloc({
    required this.propertyDetailRepository,
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
      await propertyDetailRepository.unfavorProperty(propertyId);
    } catch (e) {
      // ignore
    }
  }

  void _handlePostFavorite() async {
    try {
      await propertyDetailRepository.favorProperty(propertyId);
    } catch (e) {
      // ignore
    }
  }
}
