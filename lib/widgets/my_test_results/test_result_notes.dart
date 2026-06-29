import 'package:flutter/material.dart';

class TestResultNotes extends StatelessWidget {
  final String notes;

  const TestResultNotes({
    super.key,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text(notes),
    );
  }
}