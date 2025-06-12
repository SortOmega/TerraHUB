import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/firebase_options.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';
import 'shared/routes.dart';
import 'shared/redirect.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializar almacenamiento local
  await GetStorage.init();

  // Eliminar el hash "#" de las URLs web
  setPathUrlStrategy();

  // Inicializar Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Persistencia de Firebase Auth
  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }
  // Fijar orientación a vertical
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TerraHub',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      routes: redirect,
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (_) => const Scaffold()),
    );
  }
}
