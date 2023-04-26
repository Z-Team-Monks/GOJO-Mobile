import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: const [
              CircleAvatar(
                radius: 25,
                child: Icon(Icons.person_off_outlined),
              ),
              SizedBox(width: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Kebede Alemayehu",
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "The property exceeded my expectations with modern amenities, cozy atmosphere, and perfect location.",
            ),
          ),
          const SizedBox(height: 10),
          const HorizontalUnderline(color: Colors.grey),
        ],
      ),
    );
  }
}

class HorizontalUnderline extends StatelessWidget {
  final Color color;
  const HorizontalUnderline({
    super.key,
    this.color = Colors.redAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 18.0),
      child: Container(
        height: 1,
        color: color,
      ),
    );
  }
}
