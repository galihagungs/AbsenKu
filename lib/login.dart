import 'package:absenku/homepage.dart';
import 'package:absenku/register.dart';
import 'package:absenku/service/UserService.dart';
import 'package:absenku/utils/utils.dart';
import 'package:absenku/utils/wiget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final List<String> imgList = [
    'assets/images/carousel1.jpg',
    'assets/images/carousel2.jpg',
    'assets/images/carousel3.jpg',
  ];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset('assets/images/iconlogo.png', width: 50),
                SizedBox(width: 10),
                Text("Absen Ku", style: kanit25boldMain),
              ],
            ),
            SizedBox(height: 50),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items:
                  imgList.map((e) {
                    return Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Image.asset(e, fit: BoxFit.cover, width: 1000.0),
                      ),
                    );
                  }).toList(),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Dengan AbsenKu", style: kanit25boldMain),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text("Presensi lebih mudah", style: kanit25bold),
            ),
            SizedBox(height: 20),
            textFieldCustomIcon(
              prefixIcon: Icon(FluentIcons.mail_16_filled),
              hint: "Email",
              isPasword: false,
              controller: _email,
            ),
            SizedBox(height: 10),
            textFieldCustomIcon(
              prefixIcon: Icon(FluentIcons.password_16_filled),
              hint: "Password",
              isPasword: true,
              controller: _password,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Belum Punya Akun? ", style: kanit14Normal),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(" Registrasi", style: kanit14Bold),
                ),
              ],
            ),
            SizedBox(height: 25),
            isLoading
                ? Lottie.asset(
                  'assets/images/loadinganimation.json',
                  width: 100,
                  // repeat: false,
                  fit: BoxFit.fitWidth,
                )
                : uniButton(
                  context,
                  title: Text("Login", style: kanit16semiBoldMainWhite),
                  warna: mainColor,
                  func: () {
                    procedLogin(context);
                  },
                ),
          ],
        ),
      ),
    );
  }

  Future<void> procedLogin(BuildContext context) async {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      bool status = await UserService().login(
        email: _email.text,
        password: _password.text,
      );

      if (status == true) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
          content: const Text('Lengkapi Form Login'),
        ),
      );
    }
  }
}
