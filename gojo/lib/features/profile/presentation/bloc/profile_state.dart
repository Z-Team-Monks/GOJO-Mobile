part of 'profile_bloc.dart';

enum FetchProfileMediaItemStatus { loading, loaded, error }

@immutable
class ProfileState {
  final List<ProfileMediaItem> rentedMediaItems;
  final List<ProfileMediaItem> favoriteMediaItems;
  final FetchProfileMediaItemStatus rentedMediaItemsFetchStatus;
  final FetchProfileMediaItemStatus favoriteMediaItemsFetchStatus;

  const ProfileState({
    required this.rentedMediaItems,
    required this.favoriteMediaItems,
    required this.rentedMediaItemsFetchStatus,
    required this.favoriteMediaItemsFetchStatus,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      rentedMediaItems: [],
      favoriteMediaItems: [],
      rentedMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
      favoriteMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
    );
  }

  ProfileState copyWith({
    List<ProfileMediaItem>? rentedMediaItems,
    List<ProfileMediaItem>? favoriteMediaItems,
    FetchProfileMediaItemStatus? rentedMediaItemsFetchStatus,
    FetchProfileMediaItemStatus? favoriteMediaItemsFetchStatus,
  }) {
    return ProfileState(
      rentedMediaItems: rentedMediaItems ?? this.rentedMediaItems,
      favoriteMediaItems: favoriteMediaItems ?? this.favoriteMediaItems,
      rentedMediaItemsFetchStatus:
          rentedMediaItemsFetchStatus ?? this.rentedMediaItemsFetchStatus,
      favoriteMediaItemsFetchStatus:
          favoriteMediaItemsFetchStatus ?? this.favoriteMediaItemsFetchStatus,
    );
  }
}
