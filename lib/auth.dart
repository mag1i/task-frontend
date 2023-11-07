import 'package:flutter/widgets.dart';
import 'package:hypenettask/user.dart';

/*class AuthProvider extends ChangeNotifier {
  String _token;

  String get token => _token;

  void login(String token) {
    _token = token;
    notifyListeners(); // Notify all listeners about state change.
  }

  void logout() {
    _token = null;
    notifyListeners(); // Notify all listeners about state change.
  }
}
*/
//String token = Provider.of<AuthProvider>(context, listen: false).token;
//Provider.of<AuthProvider>(context, listen: false).login('newToken');
//Provider.of<AuthProvider>(context, listen: false).logout();
class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void login(String token) {
    _user = User(token);
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
/*Consumer<AuthProvider>(
  builder: (context, authProvider, child) {
    if (authProvider.token != null) {
      return HomeScreen(); // User is logged in
    } else {
      return LoginScreen(); // User is not logged in
    }
  },
);
*/