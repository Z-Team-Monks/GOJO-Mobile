import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_landlord/features/profile/data_layer/repository/profile_repository.dart';
import 'package:meta/meta.dart';

part 'end_contract_event.dart';
part 'end_contract_state.dart';

class EndContractBloc extends Bloc<EndContractEvent, EndContractState> {
  final ProfileRepositoryAPI profileRepository;
  EndContractBloc(this.profileRepository) : super(EndContractState.initial) {
    on<EndContract>((event, emit) async {
      emit(EndContractState.loading);
      try {
        await profileRepository.endContract(event.propertyId);
        emit(EndContractState.success);
      } catch (e) {
        emit(EndContractState.error);
      }
    });
  }
}
