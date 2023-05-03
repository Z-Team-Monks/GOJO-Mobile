part of 'profile_bloc.dart';

enum FetchProfileMediaItemStatus { loading, loaded, error }

@immutable
class ProfileState {
  final List<PostedMediaItem> postedMediaItems;
  final List<InReviewMediaItem> inReviewMediaItems;
  final FetchProfileMediaItemStatus postedMediaItemsFetchStatus;
  final FetchProfileMediaItemStatus inReviewMediaItemsFetchStatus;

  const ProfileState({
    required this.postedMediaItems,
    required this.inReviewMediaItems,
    required this.postedMediaItemsFetchStatus,
    required this.inReviewMediaItemsFetchStatus,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      postedMediaItems: [],
      inReviewMediaItems: [],
      postedMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
      inReviewMediaItemsFetchStatus: FetchProfileMediaItemStatus.loading,
    );
  }

  ProfileState copyWith({
    List<PostedMediaItem>? postedMediaItems,
    List<InReviewMediaItem>? inReviewMediaItems,
    FetchProfileMediaItemStatus? postedMediaItemsFetchStatus,
    FetchProfileMediaItemStatus? inReviewMediaItemsFetchStatus,
  }) {
    return ProfileState(
      postedMediaItems: postedMediaItems ?? this.postedMediaItems,
      inReviewMediaItems: inReviewMediaItems ?? this.inReviewMediaItems,
      postedMediaItemsFetchStatus:
          postedMediaItemsFetchStatus ?? this.postedMediaItemsFetchStatus,
      inReviewMediaItemsFetchStatus:
          inReviewMediaItemsFetchStatus ?? this.inReviewMediaItemsFetchStatus,
    );
  }
}
