import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data_layer/repository/profile_repository.dart';
import '../screen/model/profile_media_item.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositoryAPI profileRepository;

  ProfileBloc(this.profileRepository) : super(ProfileState.initial()) {
    on<LoadProfileData>((event, emit) async {
      emit(state.copyWith(
        rentedMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
        favoriteMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
      ));

      try {
        final rentedProperties = await profileRepository.getRentedProperties();
        final rentedPropertyMediaItems = rentedProperties.items
            .map((propertyItem) => ProfileMediaItem.fromPropertyItem(
                  propertyItem,
                ))
            .toList();

        emit(state.copyWith(
          rentedMediaItems: rentedPropertyMediaItems,
          rentedMediaItemsFetchStatus: FetchProfileMediaItemStatus.loaded,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          rentedMediaItemsFetchStatus: FetchProfileMediaItemStatus.error,
        ));
      }

      try {
        final favoriteProperties =
            await profileRepository.getFavoriteProperties();
        final appliedPropertyMediaItems = favoriteProperties.items
            .map((propertyItem) => ProfileMediaItem.fromPropertyItem(
                  propertyItem,
                ))
            .toList();

        emit(state.copyWith(
          favoriteMediaItems: appliedPropertyMediaItems,
          favoriteMediaItemsFetchStatus: FetchProfileMediaItemStatus.loaded,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          favoriteMediaItemsFetchStatus: FetchProfileMediaItemStatus.error,
        ));
      }
    });
  }
}
