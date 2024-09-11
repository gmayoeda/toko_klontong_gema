import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toko_klontong_gema/data/local/local_storage.dart';
import 'package:toko_klontong_gema/utils/config/routes/route_manager.dart';
import 'package:toko_klontong_gema/utils/config/theme/themes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String versionNumber = '';
  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      versionNumber = info.version;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initPackageInfo();
      await Future.delayed(const Duration(seconds: 3), () async {
        await StatusLoginPreferences.getStatusLogin().then((value) {
          if (kDebugMode) {
            print("Status lOGIN : $value");
          }
          value != null && value == 'true'
              ? Navigator.of(context)
                  .pushNamedAndRemoveUntil(RouteManager.main, (route) => false)
              : Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteManager.login, (route) => false);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  width: 80,
                ),
                const SizedBox(height: 12),
                Text(
                  versionNumber != '' ? "Version $versionNumber" : "",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: LinearProgressIndicator(
                      minHeight: 5,
                      backgroundColor: mainColors.withOpacity(0.30)),
                )
              ],
            ),
          ),
          const Positioned(
            bottom: 20,
            child: Text(
              'Powered by Gema Projects',
              style: TextStyle(
                color: Colors.black45,
                fontFamily: 'Nunito',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
