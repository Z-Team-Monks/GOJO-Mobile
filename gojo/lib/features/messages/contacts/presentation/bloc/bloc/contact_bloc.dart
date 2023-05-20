import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gojo/features/messages/contacts/data/repository/contact_repository.dart';

import '../../../data/model/contact.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;

  ContactBloc(this.contactRepository) : super(const ContactState()) {
    on<ContactLoad>((event, emit) async {
      emit(state.copyWith(fetchStatus: FetchContactsStatus.loading));
      try {
        final contacts = await contactRepository.getContacts();

        emit(state.copyWith(
          contacts: contacts,
          fetchStatus: FetchContactsStatus.success,
        ));
      } catch (e) {
        emit(state.copyWith(fetchStatus: FetchContactsStatus.error));
      }
    });
  }
}
