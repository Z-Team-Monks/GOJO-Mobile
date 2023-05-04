import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data_layer/repository/profile_repository.dart';
import '../screens/model/profile_media_item.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositoryAPI profileRepository;

  ProfileBloc(this.profileRepository) : super(ProfileState.initial()) {
    on<LoadProfileData>((event, emit) async {
      emit(state.copyWith(
        rentedMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
        appliedMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
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
        emit(state.copyWith(
          rentedMediaItemsFetchStatus: FetchProfileMediaItemStatus.error,
        ));
      }

      try {
        final appliedProperties =
            await profileRepository.getAppliedProperties();
        final appliedPropertyMediaItems = appliedProperties.items
            .map((propertyItem) => ProfileMediaItem.fromPropertyItem(
                  propertyItem,
                ))
            .toList();

        emit(state.copyWith(
          appliedMediaItems: appliedPropertyMediaItems,
          appliedMediaItemsFetchStatus: FetchProfileMediaItemStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
          appliedMediaItemsFetchStatus: FetchProfileMediaItemStatus.error,
        ));
      }
    });
  }
}
