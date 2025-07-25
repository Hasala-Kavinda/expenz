import 'package:expenz/constants/colors.dart';
import 'package:expenz/data/onboarding_data.dart';
import 'package:expenz/screens/onboarding/front_page.dart';
import 'package:expenz/screens/onboarding/shared_onboarding_screen.dart';
import 'package:expenz/screens/user_data_screen.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

  bool showDetailsPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                //Onboarding pages list is passed here
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailsPage = index == 3;
                      print(showDetailsPage);
                    });
                  },
                  children: [
                    const FrontPage(),
                    SharedOnboardingScreen(
                      title: OnboardingData.onbardingDataList[0].title,
                      imagePath: OnboardingData.onbardingDataList[0].imagePath,
                      description:
                          OnboardingData.onbardingDataList[0].description,
                    ),
                    SharedOnboardingScreen(
                      title: OnboardingData.onbardingDataList[1].title,
                      imagePath: OnboardingData.onbardingDataList[1].imagePath,
                      description:
                          OnboardingData.onbardingDataList[1].description,
                    ),
                    SharedOnboardingScreen(
                      title: OnboardingData.onbardingDataList[2].title,
                      imagePath: OnboardingData.onbardingDataList[2].imagePath,
                      description:
                          OnboardingData.onbardingDataList[2].description,
                    ),
                  ],
                ),

                //the page indicators

                Container(
                  alignment: const Alignment(0, 0.8),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const WormEffect(
                      activeDotColor: kMainColor,
                      dotColor: kLightGrey,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: !showDetailsPage
                        ? GestureDetector(
                            onTap: () {
                              _controller.animateToPage(
                                _controller.page!.toInt() + 1,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: CustomButton(
                              name: showDetailsPage ? "Get Started" : "Next",
                              buttonColor: kMainColor,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              // Navigate to the user data screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const UserDataScreen(),
                                  ));
                            },
                            child: CustomButton(
                              name: showDetailsPage ? "Get Started" : "Next",
                              buttonColor: kMainColor,
                            ),
                          ),
                  ),
                )

                //navigation button
              ],
            ),
          ),
        ],
      ),
    );
  }
}
