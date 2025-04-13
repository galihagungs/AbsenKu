import 'package:absenku/login.dart';
import 'package:absenku/utils/utils.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  void _onIntroEnd(context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    // const bodyStyle = TextStyle(fontSize: 19.0);
    // const pageDecoration = PageDecoration(
    //   titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
    //   bodyTextStyle: bodyStyle,
    //   bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    //   pageColor: Colors.white,
    //   imagePadding: EdgeInsets.zero,
    // );
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: bgColor,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,

      pages: [
        PageViewModel(
          title: "",
          decoration: PageDecoration(bodyAlignment: Alignment.center),
          bodyWidget: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Stack(
                children: [
                  Image.asset("assets/images/onboarding1.png", width: 350),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Provides attendance management",
                          style: kanit30bold,
                        ),
                        SizedBox(height: 25),
                        Text(
                          "Make it easy to manage your employee attendance data",
                          style: kanit16normal,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          decoration: PageDecoration(bodyAlignment: Alignment.center),
          bodyWidget: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Stack(
                children: [
                  Lottie.asset(
                    'assets/images/onboarding2.json',
                    width: 350,
                    repeat: false,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.42,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Track \n Attendance Location",
                          style: kanit30bold,
                        ),
                        SizedBox(height: 25),
                        Text(
                          "Provide GPS solution to track employee attendance",
                          style: kanit16normal,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          decoration: PageDecoration(bodyAlignment: Alignment.center),
          bodyWidget: Column(
            children: [
              // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Image.asset('assets/images/logonobox.png', width: 300),
              Text("This is the solution for you", style: kanit25bold),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(mainColor),
                ),
                child: Text("Let's get started", style: kanit20normalWhite),
              ),
            ],
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      controlsPosition: Position.fromLTRB(
        -100,
        MediaQuery.of(context).size.height * 0.85,
        200,
        0,
      ),
      showBackButton: false,
      showNextButton: false,
      showDoneButton: false,
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: Text('Done', style: poppins16italic),
      curve: Curves.fastLinearToSlowEaseIn,

      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: mainColor,
        color: Colors.black26,

        spacing: const EdgeInsets.symmetric(horizontal: 0.5),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
