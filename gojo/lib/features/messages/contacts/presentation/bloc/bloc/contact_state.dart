part of 'contact_bloc.dart';

enum FetchContactsStatus { loading, success, error }

class ContactState {
  final List<Contact> contacts;
  final FetchContactsStatus fetchStatus;

  const ContactState({
    this.contacts = const [],
    this.fetchStatus = FetchContactsStatus.loading,
  });

  ContactState copyWith({
    List<Contact>? contacts,
    FetchContactsStatus? fetchStatus,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
      fetchStatus: fetchStatus ?? this.fetchStatus,
    );
  }
}
