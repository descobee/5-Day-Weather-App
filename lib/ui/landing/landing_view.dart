// ignore_for_file: use_build_context_synchronously

import 'package:fifthlab_assessment/ui/homescreen/homescreen_view.dart';
import 'package:fifthlab_assessment/ui/homescreen/homescreen_viewmodel.dart';
import 'package:fifthlab_assessment/ui/landing/landing_viewmodel.dart';
import 'package:fifthlab_assessment/ui/shared_widgets/spacing_widgets.dart';
import 'package:fifthlab_assessment/ui/ui_helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingView extends ConsumerStatefulWidget {
  const LandingView({super.key});

  @override
  ConsumerState<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends ConsumerState<LandingView> {
  @override
  Widget build(BuildContext context) {
    final controller2 = ref.watch(landingViewProvider);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Press the button to proceed",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const YMargin(40),
            SizedBox(
              width: screenWidth(context, percent: 0.6),
              height: 50,
              child: ElevatedButton(
                  onPressed: () async {
                    await controller2.setLocation();
                    Helpers.log(
                        controller2.model?.latitude.toString() ?? "No show");
                    await ref.watch(homescreenProvider).getWeather(context);
                    await ref.watch(homescreenProvider).getForecast(context);
                    // controller2.isLoading = false;
                    await Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const HomescreenView();
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child:
                      //  controller2.isLoading
                      //     ? const Center(
                      //         child: CircularProgressIndicator(),
                      //       )
                      //     :
                      const Text(
                    "Proceed",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )),
            )
          ],
        ),
      )),
    );
  }
}
