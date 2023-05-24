import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/property.dart';
import '../../data/repository/detail_repository.dart';

part 'property_detail_event.dart';
part 'property_detail_state.dart';

class PropertyDetailBloc
    extends Bloc<PropertyDetailEvent, PropertyDetailState> {
  final PropertyDetailRepository propertyDetailRepository;

  PropertyDetailBloc({required this.propertyDetailRepository})
      : super(const PropertyDetailState()) {
    on<LoadPropertyDetail>((event, emit) async {
      emit(state.copyWith(status: FetchPropertyDetailStatus.loading));
      try {
        final property =
            await propertyDetailRepository.fetchProperty(event.propertyId);
        emit(
          state.copyWith(
            property: property,
            status: FetchPropertyDetailStatus.success,
          ),
        );
      } catch (e) {
        emit(state.copyWith(status: FetchPropertyDetailStatus.error));
      }
    });
  }
}
