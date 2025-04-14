import 'package:absenku/onboarding.dart';
import 'package:absenku/service/pref_handler.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String data1 = '';
  String data2 = '';
  @override
  void initState() {
    super.initState();
    initUser();
  }

  void initUser() async {
    data1 = await PreferenceHandler.getId();
    data2 = await PreferenceHandler.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(data1),
          Text(data2),
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
    );
  }
}
