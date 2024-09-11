import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:toko_klontong_gema/utils/commons/loading/custom_loading.dart';
import 'package:toko_klontong_gema/utils/config/bloc/multi_bloc_provider.dart';
import 'package:toko_klontong_gema/utils/config/routes/route_manager.dart';
import 'package:toko_klontong_gema/utils/config/theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: mainColors));

    return MultiBlocProviders(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Klontong GEMA',
        theme: themeData,
        builder: FlutterSmartDialog.init(
          loadingBuilder: (String msg) => const CustomLoading(type: 1),
        ),
        initialRoute: RouteManager.splash,
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
