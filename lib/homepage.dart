import 'package:absenku/onboarding.dart';
import 'package:absenku/service/pref_handler.dart';
import 'package:absenku/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    initUser();
  }

  void initUser() async {
    await PreferenceHandler.getId();
    await PreferenceHandler.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/images/iconlogo.png', width: 50),
                SizedBox(width: 10),
                Text("Absen Ku", style: kanit25boldMain),
              ],
            ),
            SizedBox(height: 25),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                decoration: BoxDecoration(color: bgColor),
                child: LottieBuilder.asset(
                  'assets/images/person.json',
                  width: 80,
                  height: 80,
                  // fit: BoxFit.cover,
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                ),
                // child: Image.asset(
                //   'assets/images/carousel1.jpg',
                //   width: 150,
                //   fit: BoxFit.fitHeight,
                // ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  PreferenceHandler.removeId();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => OnboardingPage()),
                  );
                },
                child: Text("LOGOUT"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
