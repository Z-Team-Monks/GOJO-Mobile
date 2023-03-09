import 'package:flutter/widgets.dart';
import 'package:group_button/group_button.dart';

class GojoTextRadioButton extends StatelessWidget {
  final String label;
  final List<String> items;
  final Function(String, int, bool)? onItemSelected;

  const GojoTextRadioButton({
    super.key,
    required this.label,
    required this.items,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        GroupButton(
          isRadio: true,
          onSelected: ((value, index, isSelected) {
            print('$value button is selected');
          }),
          buttons: items,
        ),
      ],
    );
  }
}
