part of 'profile_bloc.dart';

enum FetchProfileMediaItemStatus { loading, loaded, error }

@immutable
class ProfileState {
  final List<ProfileMediaItem> rentedMediaItems;
  final List<ProfileMediaItem> appliedMediaItems;
  final FetchProfileMediaItemStatus rentedMediaItemsFetchStatus;
  final FetchProfileMediaItemStatus appliedMediaItemsFetchStatus;

  const ProfileState({
    required this.rentedMediaItems,
    required this.appliedMediaItems,
    required this.rentedMediaItemsFetchStatus,
    required this.appliedMediaItemsFetchStatus,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      rentedMediaItems: [],
      appliedMediaItems: [],
      rentedMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
      appliedMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
    );
  }

  ProfileState copyWith({
    List<ProfileMediaItem>? rentedMediaItems,
    List<ProfileMediaItem>? appliedMediaItems,
    FetchProfileMediaItemStatus? rentedMediaItemsFetchStatus,
    FetchProfileMediaItemStatus? appliedMediaItemsFetchStatus,
  }) {
    return ProfileState(
      rentedMediaItems: rentedMediaItems ?? this.rentedMediaItems,
      appliedMediaItems: appliedMediaItems ?? this.appliedMediaItems,
      rentedMediaItemsFetchStatus:
          rentedMediaItemsFetchStatus ?? this.rentedMediaItemsFetchStatus,
      appliedMediaItemsFetchStatus:
          appliedMediaItemsFetchStatus ?? this.appliedMediaItemsFetchStatus,
    );
  }
}
