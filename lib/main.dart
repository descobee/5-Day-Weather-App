import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: const FifthLabAssessment()));
}

class FifthLabAssessment extends StatelessWidget {
  const FifthLabAssessment({super.key});

  /// The root of the mobile application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fifthlab Mobile Dev Assessment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
