part of 'profile_bloc.dart';

enum FetchProfileMediaItemStatus { loading, loaded, error }

@immutable
class ProfileState {
  final List<PostedMediaItem> postedMediaItems;
  final List<InReviewMediaItem> inReviewMediaItems;
  final User? user;
  final FetchProfileMediaItemStatus postedMediaItemsFetchStatus;
  final FetchProfileMediaItemStatus inReviewMediaItemsFetchStatus;
  final FetchProfileMediaItemStatus userLoadStatus;

  const ProfileState({
    required this.postedMediaItems,
    required this.inReviewMediaItems,
    required this.postedMediaItemsFetchStatus,
    required this.inReviewMediaItemsFetchStatus,
    required this.userLoadStatus,
    required this.user,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      postedMediaItems: [],
      inReviewMediaItems: [],
      user: null,
      userLoadStatus: FetchProfileMediaItemStatus.loading,
      postedMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
      inReviewMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
    );
  }

  ProfileState copyWith({
    List<PostedMediaItem>? postedMediaItems,
    List<InReviewMediaItem>? inReviewMediaItems,
    User? user,
    FetchProfileMediaItemStatus? postedMediaItemsFetchStatus,
    FetchProfileMediaItemStatus? inReviewMediaItemsFetchStatus,
    FetchProfileMediaItemStatus? userLoadStatus,
  }) {
    return ProfileState(
      postedMediaItems: postedMediaItems ?? this.postedMediaItems,
      inReviewMediaItems: inReviewMediaItems ?? this.inReviewMediaItems,
      user: user ?? this.user,
      postedMediaItemsFetchStatus:
          postedMediaItemsFetchStatus ?? this.postedMediaItemsFetchStatus,
      inReviewMediaItemsFetchStatus:
          inReviewMediaItemsFetchStatus ?? this.inReviewMediaItemsFetchStatus,
      userLoadStatus: userLoadStatus ?? this.userLoadStatus,
    );
  }
}
