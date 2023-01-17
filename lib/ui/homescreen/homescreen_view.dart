import 'package:fifthlab_assessment/core/constants/app_strings.dart';
import 'package:fifthlab_assessment/ui/homescreen/homescreen_viewmodel.dart';
import 'package:fifthlab_assessment/ui/shared_widgets/spacing_widgets.dart';
import 'package:fifthlab_assessment/ui/ui_helpers/asset_helpers.dart';
import 'package:fifthlab_assessment/ui/ui_helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomescreenView extends ConsumerStatefulWidget {
  const HomescreenView({super.key});

  @override
  ConsumerState<HomescreenView> createState() => _HomescreenViewState();
}

class _HomescreenViewState extends ConsumerState<HomescreenView> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(homescreenProvider);
    controller.weatherResponseModel == null
        ? Helpers.log("Null Error oh")
        : Helpers.log(controller.weatherResponseModel!.weather![0]!.icon!);
    return Scaffold(
      backgroundColor: controller
          .weatherColor(controller.weatherResponseModel!.weather![0]!.icon!),
      body: SafeArea(
        child: controller.isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  controller.getWeather(context);
                  controller.getForecast(context);
                },
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Stack(
                      children: [
                        AppImage(
                          path: controller.weatherImage(controller
                                  .weatherResponseModel!.weather![0]!.icon ??
                              AppStrings.sunny),
                          height: screenHeight(
                            context,
                            percent: 0.4,
                          ),
                          width: double.infinity,
                          boxFit: BoxFit.cover,
                        ),
                        Positioned(
                            top: screenHeight(context, percent: 0.1),
                            left: screenWidth(context, percent: 0.35),
                            child: Text(
                              "${controller.weatherResponseModel!.main!.temp.toString()}°\n${controller.weatherResponseModel!.weather![0]!.main}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${controller.weatherResponseModel!.main!.tempMin.toString()}°\n${AppStrings.minTemp}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${controller.weatherResponseModel!.main!.temp.toString()}°\n${AppStrings.currentTemp}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${controller.weatherResponseModel!.main!.tempMax.toString()}°\n${AppStrings.maxTemp}",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const YMargin(6),
                          const Divider(color: Colors.white, height: 2),
                          const YMargin(14),
                        ],
                      ),
                    ),
                    ...List.generate(
                        controller.weatherResponseModelList.data!.length,
                        (index) => controller.weatherResponseModelList.data![index]!.dtx.toString().contains("9:00:00") ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('EEEE').format(controller
                                        .weatherResponseModelList
                                        .data![index]!
                                        .dtx!),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  AppImage(
                                    path: controller.weatherIcons(controller
                                        .weatherResponseModelList
                                        .data![index]!
                                        .weather![0]!
                                        .icon!),
                                    height: 50,
                                    width: 50,
                                  ),
                                  Text(
                                    "${controller.weatherResponseModelList.data![index]!.main!.temp.toString()}°",
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ): Container() ) ,
                  ],
                ),
              ),
      ),
    );
  }
}
