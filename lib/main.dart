import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:leaf_it/Analytics/AnalyticsTab.dart';
import 'package:leaf_it/Controller/ControllerTab.dart';
import 'package:leaf_it/HomeScreen/Homescreen.dart';
import 'package:leaf_it/MainTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:leaf_it/splash.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (_) => LocaleProvider(),child: MyApp()));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return MaterialApp(
      title: 'LeafIT',
      theme: MainTheme.lightMode,
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        ControllerTab.routeName: (context) => ControllerTab(),
        AnalyticsTab.routeName: (context) => AnalyticsTab(),
      },
      initialRoute: SplashScreen.routeName,
      locale: localeProvider.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
