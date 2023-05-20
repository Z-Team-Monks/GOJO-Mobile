part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {}

class ContactLoad extends ContactEvent {
  ContactLoad();

  @override
  List<Object> get props => [];
}
