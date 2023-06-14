import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Gojo-Mobile-Shared/UI/list_items/property_media_item.dart';
import '../../../../Gojo-Mobile-Shared/core/model/user.dart';
import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../data_layer/repository/profile_repository.dart';
import '../screen/model/profile_media_item.dart';
import '../screen/rented_media_item.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositoryAPI profileRepository;
  final UserRepositoryAPI userRepository;

  ProfileBloc(this.profileRepository, this.userRepository)
      : super(ProfileState.initial()) {
    on<LoadProfileData>((event, emit) async {
      emit(state.copyWith(
        rentedMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loading,
        favoriteMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loading,
        userLoadStatus: FetchPropertyMediaItemStatus.loading,
      ));

      try {
        final user = await userRepository.getUser();
        if (user == null) {
          throw Exception("User not saved");
        }
        emit(state.copyWith(
          user: user,
          userLoadStatus: FetchPropertyMediaItemStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
          userLoadStatus: FetchPropertyMediaItemStatus.error,
        ));
      }

      try {
        final rentedProperties = await profileRepository.getRentedProperties();
        final rentedPropertyMediaItems = rentedProperties.items
            .map((propertyItem) => RentedMediaItem.fromPropertyItem(
                  propertyItem,
                ))
            .toList();

        emit(state.copyWith(
          rentedMediaItems: rentedPropertyMediaItems,
          rentedMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loaded,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          rentedMediaItemsFetchStatus: FetchPropertyMediaItemStatus.error,
        ));
      }

      try {
        final favoriteProperties =
            await profileRepository.getFavoriteProperties();
        final appliedPropertyMediaItems = favoriteProperties.items
            .map((propertyItem) => PropertyMediaItemExtension.fromPropertyItem(
                  propertyItem,
                ))
            .toList();

        emit(state.copyWith(
          favoriteMediaItems: appliedPropertyMediaItems,
          favoriteMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loaded,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          favoriteMediaItemsFetchStatus: FetchPropertyMediaItemStatus.error,
        ));
      }
    });
  }
}
