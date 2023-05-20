import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo/features/detail/presentation/screen/detail.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../../Gojo-Mobile-Shared/UI/list_items/content_item.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../../../../../constants/strings/app_routes.dart';
import '../../data/model/chat.dart';
import '../../data/repository/contact_repository.dart';
import '../../../../../navigation/args/chat_args.dart';
import '../bloc/bloc/contact_bloc.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(
        GetIt.I<ContactRepositoryFakeImpl>(),
      )..add(ContactLoad()),
      child: const _ContactsView(),
    );
  }
}

/// Represents a screen with a list view of user's chat history.
class _ContactsView extends StatelessWidget {
  const _ContactsView();

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Messages",
      child: Column(
        children: [
          const SizedBox(height: 10),
          BlocBuilder<ContactBloc, ContactState>(
            builder: (context, state) {
              switch (state.fetchStatus) {
                case FetchContactsStatus.loading:
                  return const LoadingView();
                case FetchContactsStatus.error:
                  return const ErrorView();
                default:
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.contacts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (() {
                          Navigator.pushNamed(
                            context,
                            GojoRoutes.chat,
                            arguments: ChatArgs(
                              messages: state.contacts[index].chatMessages,
                            ),
                          );
                        }),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: GojoPadding.small),
                          child: GojoContentItem(
                            image: AssetImage(Resources.gojoImages.headShot),
                            title:
                                "${state.contacts[index].sender.firstName} ${state.contacts[index].sender.lastName}",
                            content:
                                state.contacts[index].chatMessages[0].message,
                            rightAlignedTitle:
                                state.contacts[index].chatMessages[0].timestamp,
                            rightAlignedContent:
                                "${state.contacts[index].unreadMessages}",
                          ),
                        ),
                      );
                    },
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
