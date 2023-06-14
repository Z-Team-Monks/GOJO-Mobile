import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gojo/features/property/favorite/bloc/favorite_bloc.dart';

import 'package:mockito/mockito.dart';

import '../../apply_for_rent/bloc/apply_for_rent_bloc_test.mocks.dart';

void main() {
  late FavoriteBloc favoriteBloc;
  late MockPropertyDetailRepository mockRepository;

  setUp(() {
    mockRepository = MockPropertyDetailRepository();
    favoriteBloc = FavoriteBloc(
      propertyDetailRepository: mockRepository,
      propertyId: 1,
    );
  });

  group('FavoriteBloc', () {
    blocTest<FavoriteBloc, FavoriteState>(
      'emits LoadFavorite state',
      build: () => favoriteBloc,
      act: (bloc) => bloc.add(LoadFavorite(isFavorite: true)),
      expect: () => [
        const FavoriteState(
          isFavorite: true,
          status: FavoriteStatus.loading,
        ),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'emits FavoriteStatusChanged state and success status',
      build: () => favoriteBloc,
      act: (bloc) {
        when(mockRepository.favorProperty(any))
            .thenAnswer((_) => Future.value());
        bloc.add(FavoriteStatusChanged());
      },
      expect: () => [
        const FavoriteState(
          isFavorite: true,
        ),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'handles error',
      build: () => favoriteBloc,
      act: (bloc) {
        when(mockRepository.favorProperty(any)).thenThrow(Exception('Error'));
        bloc.add(FavoriteStatusChanged());
      },
      expect: () => [],
    );
  });
}
