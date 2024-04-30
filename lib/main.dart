import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:luvit/app/app.locator.dart';
import 'package:luvit/app/app.router.dart';
import 'package:luvit/firebase_options.dart';
import 'package:luvit/ui/common/app_colors.dart';
import 'package:luvit/ui/common/ui_helpers.dart';
import 'package:luvit/ui/views/home/home_view.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        primaryColor: kcPrimaryColor,
        splashColor: kcTransparent,
        highlightColor: kcTransparent,
        hoverColor: kcTransparent,
        scaffoldBackgroundColor: kcBackgroundColor,
        focusColor: kcPrimaryColor,
        textTheme:
            Theme.of(context).textTheme.apply(bodyColor: kcBackgroundColor),
      ),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: systemUiOverlayStyle,
        child: const HomeView(),
      ),
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
