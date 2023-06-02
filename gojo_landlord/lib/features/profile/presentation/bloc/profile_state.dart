part of 'profile_bloc.dart';

enum FetchPropertyMediaItemStatus { loading, loaded, error }

@immutable
class ProfileState {
  final List<PostedMediaItem> postedMediaItems;
  final List<InReviewMediaItem> inReviewMediaItems;
  final List<RentedMediaItem> rentedMediaItems;
  final User? user;
  final FetchPropertyMediaItemStatus postedMediaItemsFetchStatus;
  final FetchPropertyMediaItemStatus inReviewMediaItemsFetchStatus;
  final FetchPropertyMediaItemStatus rentedItemsFetchStatus;
  final FetchPropertyMediaItemStatus userLoadStatus;

  const ProfileState({
    required this.postedMediaItems,
    required this.inReviewMediaItems,
    required this.rentedMediaItems,
    required this.user,
    required this.postedMediaItemsFetchStatus,
    required this.inReviewMediaItemsFetchStatus,
    required this.rentedItemsFetchStatus,
    required this.userLoadStatus,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      postedMediaItems: [],
      inReviewMediaItems: [],
      rentedMediaItems: [],
      user: null,
      postedMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loading,
      inReviewMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loading,
      rentedItemsFetchStatus: FetchPropertyMediaItemStatus.loading,
      userLoadStatus: FetchPropertyMediaItemStatus.loading,
    );
  }

  ProfileState copyWith({
    List<PostedMediaItem>? postedMediaItems,
    List<InReviewMediaItem>? inReviewMediaItems,
    List<RentedMediaItem>? rentedMediaItems,
    User? user,
    FetchPropertyMediaItemStatus? postedMediaItemsFetchStatus,
    FetchPropertyMediaItemStatus? inReviewMediaItemsFetchStatus,
    FetchPropertyMediaItemStatus? rentedItemsFetchStatus,
    FetchPropertyMediaItemStatus? userLoadStatus,
  }) {
    return ProfileState(
      postedMediaItems: postedMediaItems ?? this.postedMediaItems,
      inReviewMediaItems: inReviewMediaItems ?? this.inReviewMediaItems,
      rentedMediaItems: rentedMediaItems ?? this.rentedMediaItems,
      user: user ?? this.user,
      postedMediaItemsFetchStatus:
          postedMediaItemsFetchStatus ?? this.postedMediaItemsFetchStatus,
      inReviewMediaItemsFetchStatus:
          inReviewMediaItemsFetchStatus ?? this.inReviewMediaItemsFetchStatus,
      rentedItemsFetchStatus:
          rentedItemsFetchStatus ?? this.rentedItemsFetchStatus,
      userLoadStatus: userLoadStatus ?? this.userLoadStatus,
    );
  }
}
