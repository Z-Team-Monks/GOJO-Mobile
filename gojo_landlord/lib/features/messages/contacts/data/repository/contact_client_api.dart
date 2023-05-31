import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../../Gojo-Mobile-Shared/network/base_api_client.dart';

import '../model/contact.dart';

abstract class ContactClientAPI {
  Future<List<Contact>> getContacts();
}

class ContactClientImpl extends BaseApiClient implements ContactClientAPI {
  @override
  Future<List<Contact>> getContacts() async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    debugPrint(user.token);

    final fetchMessagesResponse = await get('chat/', token: user.token);
    debugPrint(fetchMessagesResponse.data.toString());
    return List<Contact>.from(
      fetchMessagesResponse.data['results']
          .map((model) => Contact.fromJson(model)),
    );
  }
}
