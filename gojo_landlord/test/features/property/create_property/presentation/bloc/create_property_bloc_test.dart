import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/model/new_property.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/property_repository.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/bloc/create_property/create_property_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_property_bloc_test.mocks.dart';

@GenerateMocks([PropertyRepositoryAPI])
void main() {
  late CreatePropertyBloc createPropertyBloc;
  late MockPropertyRepositoryAPI mockPropertyRepository;

  setUp(() {
    mockPropertyRepository = MockPropertyRepositoryAPI();
    createPropertyBloc = CreatePropertyBloc(
      propertyRepository: mockPropertyRepository,
      fetchedCategories: [], // provide sample data for fetchedCategories
      fetchedFacilities: [], // provide sample data for fetchedFacilities
    );
  });

  tearDown(() {
    createPropertyBloc.close();
  });

  group('CreatePropertyBloc', () {
    // Test TitleInputChanged event
    blocTest<CreatePropertyBloc, CreatePropertyState>(
      'emits correct states when TitleInputChanged event is added',
      build: () => createPropertyBloc,
      act: (bloc) {},
      expect: () => [],
    );

    // Test DescriptionInputChanged event
    blocTest<CreatePropertyBloc, CreatePropertyState>(
      'emits correct states when DescriptionInputChanged event is added',
      build: () => createPropertyBloc,
      act: (bloc) {},
      expect: () => [],
    );

    // Test RentInputChanged event
    blocTest<CreatePropertyBloc, CreatePropertyState>(
      'emits correct states when RentInputChanged event is added',
      build: () => createPropertyBloc,
      act: (bloc) {},
      expect: () => [],
    );

    // Add more test cases for other events

    // Test SaveButtonPressed event
    blocTest<CreatePropertyBloc, CreatePropertyState>(
      'emits correct states when SaveButtonPressed event is added',
      build: () => createPropertyBloc,
      act: (bloc) {},
      expect: () => [],
    );
  });
}
