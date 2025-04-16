import 'package:absenku/bloc/profilebloc/profile_bloc.dart';
import 'package:absenku/model/ProfileModel.dart';
import 'package:absenku/service/UserService.dart';
import 'package:absenku/utils/utils.dart';
import 'package:absenku/utils/wiget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileModel? data;
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        titleTextStyle: kanit20BoldMain,
        foregroundColor: mainColor,

        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
              onPressed: () {
                if (data != null) {
                  context.read<ProfileBloc>().add(EditMode(data: data!));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Data is not available")),
                  );
                }
              },
              icon: Icon(FluentIcons.edit_20_filled),
            ),
          ),
        ],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(
              child: LottieBuilder.asset(
                'assets/images/loadinganimation.json',
                width: 200,
                height: 200,
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
              ),
            );
          } else if (state is ProfileSuccess) {
            data = state.profileData;
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        decoration: BoxDecoration(color: bgColor),
                        child: LottieBuilder.asset(
                          'assets/images/person.json',
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Nama", style: kanit20normalMain),
                  SizedBox(height: 10),
                  Text(
                    state.profileData.data!.name.toString(),
                    style: kanit20BoldMain,
                  ),
                  SizedBox(height: 20),
                  Text("Email", style: kanit20normalMain),
                  SizedBox(height: 10),
                  Text(
                    state.profileData.data!.email.toString(),
                    style: kanit20BoldMain,
                  ),
                ],
              ),
            );
          } else if (state is ProfileEditMode) {
            nama.text = state.profileData.data!.name.toString();
            email.text = state.profileData.data!.email.toString();
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        decoration: BoxDecoration(color: bgColor),
                        child: LottieBuilder.asset(
                          'assets/images/person.json',
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Nama", style: kanit20normalMain),
                  SizedBox(height: 10),
                  textFieldCustomIcon(
                    prefixIcon: Icon(FluentIcons.person_20_filled),
                    hint: "User",
                    controller: nama,
                    isPasword: false,
                  ),
                  SizedBox(height: 20),
                  Text("Email", style: kanit20normalMain),
                  SizedBox(height: 10),
                  textFieldCustomIcon(
                    prefixIcon: Icon(FluentIcons.person_20_filled),
                    hint: "Email",
                    controller: email,
                    isPasword: false,
                  ),
                  SizedBox(height: 20),
                  uniButton(
                    context,
                    title: Text("Submit", style: kanit16normalWhite),
                    func: () {
                      // UserService().updateProfile(
                      //   email: email.text,
                      //   nama: nama.text,
                      // );
                      context.read<ProfileBloc>().add(
                        UpdateData(email: email.text, name: nama.text),
                      );
                    },
                    warna: mainColor,
                  ),
                ],
              ),
            );
          }
          return Center(child: Text("Data Tidak Ada"));
        },
      ),
    );
  }
}
