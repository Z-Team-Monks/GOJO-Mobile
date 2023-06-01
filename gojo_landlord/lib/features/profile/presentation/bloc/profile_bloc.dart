import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Gojo-Mobile-Shared/core/model/user.dart';
import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../data_layer/repository/profile_repository.dart';
import '../screens/widgets/in_review_media_item.dart';
import '../screens/widgets/posted_media_item.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepositoryAPI userRepository;
  final ProfileRepositoryAPI profileRepository;

  ProfileBloc(this.profileRepository, this.userRepository)
      : super(ProfileState.initial()) {
    on<LoadProfileData>((event, emit) async {
      emit(state.copyWith(
        postedMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
        inReviewMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
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
        final postedProperties = await profileRepository.getPostedProperties();
        final postedPropertyMediaItems = postedProperties.items
            .map((propertyItem) => PostedMediaItem.fromPropertyItem(
                  propertyItem,
                ))
            .toList();

        emit(state.copyWith(
          postedMediaItems: postedPropertyMediaItems,
          postedMediaItemsFetchStatus: FetchProfileMediaItemStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
          postedMediaItemsFetchStatus: FetchProfileMediaItemStatus.error,
        ));
      }

      try {
        final inReviewProperties =
            await profileRepository.getInReviewProperties();
        final appliedPropertyMediaItems = inReviewProperties.items
            .map((propertyItem) => InReviewMediaItem.fromPropertyItem(
                  propertyItem,
                ))
            .toList();

        emit(state.copyWith(
          inReviewMediaItems: appliedPropertyMediaItems,
          inReviewMediaItemsFetchStatus: FetchProfileMediaItemStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
          inReviewMediaItemsFetchStatus: FetchProfileMediaItemStatus.error,
        ));
      }
    });
  }
}
