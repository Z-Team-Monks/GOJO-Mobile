import 'package:flutter/material.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';

class WithdrawRequest extends StatelessWidget {
  const WithdrawRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Withdraw Request",
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
          Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Send Request"))),
        ]),
      ),
    );
  }
}
