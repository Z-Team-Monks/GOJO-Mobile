part of 'end_contract_bloc.dart';

@immutable
abstract class EndContractEvent {}

class EndContract extends EndContractEvent {
  final int propertyId;

  EndContract(this.propertyId);
}
