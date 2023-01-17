import 'package:fifthlab_assessment/core/utilities/service_locator.dart';
import 'package:fifthlab_assessment/ui/landing/landing_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  setupLocator();
  runApp(const ProviderScope(child: FifthLabAssessment()));
}

class FifthLabAssessment extends StatelessWidget {
  const FifthLabAssessment({super.key});

  /// The root of the mobile application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fifthlab Mobile Dev Assessment',
      home: const LandingView(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
