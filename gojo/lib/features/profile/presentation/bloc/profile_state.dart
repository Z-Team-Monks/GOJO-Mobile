part of 'profile_bloc.dart';

enum FetchProfileMediaItemStatus { loading, loaded, error }

@immutable
class ProfileState {
  final List<ProfileMediaItem> rentedMediaItems;
  final List<ProfileMediaItem> favoriteMediaItems;
  final User? user;
  final FetchProfileMediaItemStatus rentedMediaItemsFetchStatus;
  final FetchProfileMediaItemStatus favoriteMediaItemsFetchStatus;
  final FetchProfileMediaItemStatus userLoadStatus;

  const ProfileState({
    required this.rentedMediaItems,
    required this.favoriteMediaItems,
    required this.rentedMediaItemsFetchStatus,
    required this.favoriteMediaItemsFetchStatus,
    required this.userLoadStatus,
    required this.user,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      rentedMediaItems: [],
      favoriteMediaItems: [],
      user: null,
      rentedMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
      favoriteMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
      userLoadStatus: FetchProfileMediaItemStatus.loading,
    );
  }

  ProfileState copyWith({
    List<ProfileMediaItem>? rentedMediaItems,
    List<ProfileMediaItem>? favoriteMediaItems,
    User? user,
    FetchProfileMediaItemStatus? rentedMediaItemsFetchStatus,
    FetchProfileMediaItemStatus? favoriteMediaItemsFetchStatus,
    FetchProfileMediaItemStatus? userLoadStatus,
  }) {
    return ProfileState(
      rentedMediaItems: rentedMediaItems ?? this.rentedMediaItems,
      favoriteMediaItems: favoriteMediaItems ?? this.favoriteMediaItems,
      user: user ?? this.user,
      rentedMediaItemsFetchStatus:
          rentedMediaItemsFetchStatus ?? this.rentedMediaItemsFetchStatus,
      favoriteMediaItemsFetchStatus:
          favoriteMediaItemsFetchStatus ?? this.favoriteMediaItemsFetchStatus,
      userLoadStatus: userLoadStatus ?? this.userLoadStatus,
    );
  }
}
