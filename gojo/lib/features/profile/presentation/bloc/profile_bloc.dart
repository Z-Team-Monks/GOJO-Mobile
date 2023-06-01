import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Gojo-Mobile-Shared/core/model/user.dart';
import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../data_layer/repository/profile_repository.dart';
import '../screen/model/profile_media_item.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositoryAPI profileRepository;
  final UserRepositoryAPI userRepository;

  ProfileBloc(this.profileRepository, this.userRepository)
      : super(ProfileState.initial()) {
    on<LoadProfileData>((event, emit) async {
      emit(state.copyWith(
        rentedMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
        favoriteMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
        userLoadStatus: FetchProfileMediaItemStatus.loading,
      ));

      try {
        final user = await userRepository.getUser();
        if (user == null) {
          throw Exception("User not saved");
        }
        emit(state.copyWith(
          user: user,
          userLoadStatus: FetchProfileMediaItemStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
          userLoadStatus: FetchProfileMediaItemStatus.error,
        ));
      }

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
