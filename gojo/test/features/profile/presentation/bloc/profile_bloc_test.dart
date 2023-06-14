import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gojo/Gojo-Mobile-Shared/core/model/user.dart';

import 'package:gojo/features/home/data_layer/model/property_item.dart';
import 'package:gojo/features/profile/data_layer/repository/profile_repository.dart';
import 'package:gojo/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Import the generated mocks file
import 'profile_bloc_test.mocks.dart';

// Annotate the test file with @GenerateMocks
@GenerateMocks([ProfileRepositoryAPI])
void main() {
  late ProfileBloc profileBloc;
  late MockProfileRepositoryAPI mockProfileRepository;
  late MockUserRepositoryAPI mockUserRepository;

  setUp(() {
    mockProfileRepository = MockProfileRepositoryAPI();
    mockUserRepository = MockUserRepositoryAPI();
    profileBloc = ProfileBloc(mockProfileRepository, mockUserRepository);
  });

  group('ProfileBloc', () {
    const user = User(
      id: 1,
      firstName: '',
      lastName: '',
      phoneNumber: '',
      profilePicture: '',
    );
    blocTest<ProfileBloc, ProfileState>(
      'emits correct states for LoadProfileData event',
      build: () => profileBloc,
      act: (bloc) {
        when(mockUserRepository.getUser()).thenAnswer(
          (_) => Future.value(user),
        );
        when(mockProfileRepository.getRentedProperties())
            .thenAnswer((_) => Future.value(PropertyItemList([])));
        when(mockProfileRepository.getFavoriteProperties())
            .thenAnswer((_) => Future.value(PropertyItemList([])));
        bloc.add(LoadProfileData());
      },
      expect: () => const [
        ProfileState(
          rentedMediaItems: [],
          favoriteMediaItems: [],
          user: null,
          rentedMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loading,
          favoriteMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loading,
          userLoadStatus: FetchPropertyMediaItemStatus.loading,
        ),
        ProfileState(
          rentedMediaItems: [],
          favoriteMediaItems: [],
          user: user,
          rentedMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loading,
          favoriteMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loading,
          userLoadStatus: FetchPropertyMediaItemStatus.loaded,
        ),
        ProfileState(
          rentedMediaItems: [],
          favoriteMediaItems: [],
          user: user,
          rentedMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loaded,
          favoriteMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loading,
          userLoadStatus: FetchPropertyMediaItemStatus.loaded,
        ),
        ProfileState(
          rentedMediaItems: [],
          favoriteMediaItems: [],
          user: user,
          rentedMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loaded,
          favoriteMediaItemsFetchStatus: FetchPropertyMediaItemStatus.loaded,
          userLoadStatus: FetchPropertyMediaItemStatus.loaded,
        ),
      ],
    );

    // Add more blocTest blocks for other events if necessary
  });
}
