import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myproject/database/db_Controller.dart';
import 'package:myproject/provider/languageProvider.dart';
import 'package:myproject/provider/note_Provider.dart';
import 'package:myproject/provider/user_provider.dart';
import 'package:myproject/screens/home_Screen.dart';
import 'package:myproject/screens/launch_Screen.dart';
import 'package:myproject/screens/login_Screen.dart';
import 'package:myproject/screens/register_Screen.dart';
import 'package:myproject/shared_pref/shared_pref_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPreferences();
  await DbController().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:
    [
      ChangeNotifierProvider<LanguageProvider>(create:((context) => LanguageProvider()) ),
      ChangeNotifierProvider<NoteProvider>(create:((context) => NoteProvider()) ),
      ChangeNotifierProvider<UserProvider>(create:((context) => UserProvider()) ),
    ],
      builder: (context , widget){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        locale:Locale(Provider.of<LanguageProvider>(context).language),
        initialRoute: "/launch_Screen",
        routes: {
          "/launch_Screen": (context) => const Launch_Screen(),
          "/login_Screen": (context) => const Login_Screen(),
          "/register_Screen": (context) => const register_Screen(),
          "/Home_Screen": (context) => const Home_Screen(),


        },

      );

    },
    );
  }
}


