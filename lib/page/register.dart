import 'package:absenku/page/homepage.dart';
import 'package:absenku/service/UserService.dart';
import 'package:absenku/utils/toast.dart';
import 'package:absenku/utils/utils.dart';
import 'package:absenku/utils/wiget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/iconlogo.png', width: 40),
            SizedBox(width: 10),
            Text("Absen Ku", style: kanit25boldMain),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/register.png', width: 50),
                      SizedBox(width: 20),
                      Text("Register", style: kanit25bold),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 3),
                  Text("Nama", style: kanit20Bold),
                  SizedBox(height: 10),
                  textFieldCustomIcon(
                    prefixIcon: Icon(FluentIcons.person_20_filled),
                    hint: "Nama",
                    isPasword: false,
                    controller: _nama,
                  ),
                  SizedBox(height: 20),
                  Text("Email", style: kanit20Bold),
                  SizedBox(height: 10),
                  textFieldCustomIcon(
                    prefixIcon: Icon(FluentIcons.mail_20_filled),
                    hint: "Email",
                    isPasword: false,
                    controller: _email,
                  ),
                  SizedBox(height: 20),
                  Text("Password", style: kanit20Bold),
                  SizedBox(height: 10),
                  textFieldCustomIcon(
                    prefixIcon: Icon(FluentIcons.password_20_filled),
                    hint: "Password",
                    isPasword: true,
                    controller: _password,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            uniButton(
              context,
              title: Text("Register", style: kanit16semiBoldMainWhite),
              warna: mainColor,
              func: () async {
                if (_email.text == "" ||
                    _password.text == "" ||
                    _nama.text == "") {
                  popAlertRegis(
                    context,
                    lottieAddress: 'assets/images/information.json',
                    title: "Tolong Lengkapi From !",
                    isAlert: false,
                  );
                } else {
                  bool status = await UserService().register(
                    email: _email.text,
                    password: _password.text,
                    nama: _nama.text,
                  );
                  if (status == true) {
                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> popAlertRegis(
    BuildContext context, {
    required String lottieAddress,
    required String title,
    required bool isAlert,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            height: isAlert ? 390 : 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              children: [
                Lottie.asset(
                  lottieAddress,
                  width: 100,
                  repeat: false,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: 20),
                Text(
                  title,
                  style: kanit20BoldMain,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                uniButton(
                  context,
                  title: Text("OK", style: kanit16BoldWhite),
                  func: () {
                    Navigator.pop(context);
                  },
                  warna: mainColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
