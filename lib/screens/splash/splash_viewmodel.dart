import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:focial/screens/login/login_screen.dart';
import 'package:focial/screens/tabs_screen/tabs_screen.dart';
import 'package:focial/services/app_data.dart';
import 'package:focial/services/auth.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/utils/navigation.dart';

class SplashViewModel extends ChangeNotifier {
  bool _isInitialized = false;

  Future<void> init(BuildContext context) async {
    if (!_isInitialized) {
      _isInitialized = true;

      final authService = find<AuthService>();
      await authService.init();
      // debugPrint(authService.authData);
      if (authService.authData.isLoggedIn) {
        loggedIn(context);
      } else {
        notLoggedIn(context);
      }
    }
  }

  void loggedIn(BuildContext context) {
    debugPrint("loggedIn");
    // fetch userData in background
    find<AppDataService>().onAppOpen();
    Navigator.of(context).pushReplacement(AppNavigation.route(TabsScreen()));
  }

  void notLoggedIn(BuildContext context) {
    debugPrint("not loggedIn");
    Navigator.of(context).pushReplacement(AppNavigation.route(LoginScreen()));
  }
}
