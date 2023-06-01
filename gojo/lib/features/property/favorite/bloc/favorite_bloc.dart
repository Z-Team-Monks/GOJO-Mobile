import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
      try {
        await propertyDetailRepository.favorProperty(propertyId);
        debugPrint("property favorite status changed");
        emit(state.copywith(isFavorite: isFavorite));
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
