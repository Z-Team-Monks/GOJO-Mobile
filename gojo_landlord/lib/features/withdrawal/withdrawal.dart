import 'package:flutter/material.dart';

import '../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';

class WithdrawRequest extends StatelessWidget {
  const WithdrawRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 24)),
                onPressed: () {},
                child: const Text("Balance \$35,445")),
          ),
          const SizedBox(
            height: 36,
          ),
          TextField(
            decoration: InputDecoration(
                hintText: "Amount",
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.unfold_more),
                    Icon(Icons.attach_money)
                  ],
                )),
          ),
          Expanded(child: Container()),
          ElevatedButton(onPressed: () {}, child: const Text("Send Request")),
        ]),
      ),
    );
  }
}
