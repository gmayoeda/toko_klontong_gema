import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:toko_klontong_gema/features/auth/bloc/auth_bloc.dart';
import 'package:toko_klontong_gema/utils/commons/alert/custom_alerts.dart';
import 'package:toko_klontong_gema/utils/commons/button/custom_button_primary.dart';
import 'package:toko_klontong_gema/utils/commons/form/dynamic_textfield.dart';
import 'package:toko_klontong_gema/utils/config/routes/route_manager.dart';

import 'items/header_logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFdedede),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            SmartDialog.showLoading();
          }
          if (state is AuthLoginSuccess) {
            SmartDialog.dismiss();
            Navigator.pushNamedAndRemoveUntil(
                context, RouteManager.main, (route) => false);
          }
          if (state is AuthFailed) {
            SmartDialog.dismiss();
            displayrichAlert(context, subtitle: state.e, type: 'WARNING',
                action: () {
              Navigator.pop(context);
            });
          }
        },
        builder: (context, state) {
          return Column(
            children: [const HeaderLogo(), _formLogin()],
          );
        },
      ),
    );
  }

  _formLogin() {
    final read = context.read<AuthBloc>();
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        decoration: const BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: formkey,
                autovalidateMode: AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Hello,",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w300),
                      ),
                      const Text(
                        "Welcome back!",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        title: 'Username',
                        controller: username,
                        preffixIcon: const Icon(Icons.people),
                      ),
                      CustomTextField(
                        title: 'Password',
                        controller: password,
                        preffixIcon: const Icon(Icons.vpn_key),
                        passwordMode: true,
                        needBottom: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 35),
                        child: ButtonPrimary(
                          title: 'Login',
                          action: () {
                            final form = formkey.currentState;
                            if (form!.validate()) {
                              form.save();
                              read.add(AuthLogin(username.text, password.text));
                            }
                          },
                          icon: const Icon(Icons.login),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
