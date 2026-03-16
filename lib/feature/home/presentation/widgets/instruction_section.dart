import 'package:flutter/material.dart';

class InstructionsSection extends StatelessWidget {
  final String instructions;

  const InstructionsSection({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Instructions",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          instructions,
          style: const TextStyle(height: 1.5),
        ),
      ],
    );
  }
}