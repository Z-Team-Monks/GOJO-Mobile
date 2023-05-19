import 'package:flutter/material.dart';

class ProfileIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function() onPressed;

  const ProfileIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(-2, 2),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.black,
              ),
        )
      ],
    );
  }
}
