part of 'profile_bloc.dart';

enum FetchPropertyMediaItemStatus { loading, loaded, error }

@immutable
class ProfileState {
  final List<RentedMediaItem> rentedMediaItems;
  final List<PropertyMediaItem> favoriteMediaItems;
  final User? user;
  final FetchPropertyMediaItemStatus rentedMediaItemsFetchStatus;
  final FetchPropertyMediaItemStatus favoriteMediaItemsFetchStatus;
  final FetchPropertyMediaItemStatus userLoadStatus;

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
      rentedMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loading,
      favoriteMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loading,
      userLoadStatus: FetchPropertyMediaItemStatus.loading,
    );
  }

  ProfileState copyWith({
    List<RentedMediaItem>? rentedMediaItems,
    List<PropertyMediaItem>? favoriteMediaItems,
    User? user,
    FetchPropertyMediaItemStatus? rentedMediaItemsFetchStatus,
    FetchPropertyMediaItemStatus? favoriteMediaItemsFetchStatus,
    FetchPropertyMediaItemStatus? userLoadStatus,
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
