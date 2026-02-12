import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          CategoryButton(icon: 'assets/images/logo4.png', label: 'Mountain'),
          SizedBox(width: 8), // Space between buttons
          CategoryButton(icon: 'assets/images/logo4.png', label: 'Beach'),
          SizedBox(width: 8),
          CategoryButton(icon: 'assets/images/logo4.png', label: 'Forest'),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String icon;
  final String label;

  const CategoryButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFCBDCEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(icon),
            backgroundColor: Colors.transparent,
            radius: 20,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
                color: Colors.brown, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
