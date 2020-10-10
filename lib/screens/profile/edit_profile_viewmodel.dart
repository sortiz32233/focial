import 'package:flutter/cupertino.dart';
import 'package:focial/models/user.dart';
import 'package:focial/services/api.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/overlays.dart';
import 'package:ots/ots.dart';

final usernameRegex = RegExp('^[a-z][a-z0-9_]{3,15}');
final phoneRegex = RegExp('^[+]?[(]?[0-9]{3}[)]?[-s.]?[0-9]{3}[-s.]?[0-9]{4,6}');
// final phoneRegex = RegExp('^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}');

class EditProfileViewModel extends ChangeNotifier {
  User currentUser;
  Status _status = Status.idle;
  String _usernameMessage = "";
  bool _usernameAvailable = false;
  bool _usernameChecked = false;
  bool _usernameError = false;
  // BuildContext _context;

  void init(BuildContext context) {
    // _context = context;
    // print(find<UserData>().currentUser);
    currentUser = find<UserData>().currentUser;
  }

  final formKey = GlobalKey<FormState>();

  Future<void> updateUserProfile(BuildContext context) async {
    showLoader(isModal: true);
    final response = await find<UserData>().updateUserProfile(currentUser);
    hideLoader();
    if (response.isSuccessful) {
      Navigator.of(context).pop();
    } else {
      AppOverlays.showError("Server response", "Unable to update profile, please try later");
    }
  }

  void validateForm(BuildContext context) {
    if (!formKey.currentState.validate()) return;
    FocusScope.of(context).requestFocus(FocusNode());
    formKey.currentState.save();
    updateUserProfile(context);
  }

  String usernameValidation(String username) {
    if (username.length > 15 || username.length < 3) return "Username length is min 3 and max 15";
    if (usernameRegex.hasMatch(username)) return null;
    return "Invalid username";
  }

  String validateAge(String age) {
    if (age == null) return "Invalid age";
    try {
      final int a = int.parse(age);
      if (a > 99 || a < 6) return "Invalid age";
      return null;
    } catch (err) {
      return "Invalid age";
    }
  }

  String validatePhone(String phone) {
    if (phone == null || phone.isEmpty) return null;
    if (phoneRegex.hasMatch(phone)) return null;
    return "Invalid phone";
  }

  void updateUser(User user) {
    currentUser = user;
    notifyListeners();
  }

  Future<void> checkUsername(String username) async {
    status = Status.loading;

    if (!usernameRegex.hasMatch(username) || username.contains("@")) {
      _status = Status.idle;
      _usernameError = true;
      _usernameMessage = "Username can only contain lowercase, _, numbers"
          "\nand length can be 3 to 15";

      notifyListeners();
      return;
    } else {
      // check if username is his own
      if (currentUser.username == username) {
        print("username is not valid");
        _usernameError = false;
        _usernameChecked = false;
        _status = Status.idle;
        notifyListeners();
        return;
      } else {
        print("sending to server");
        // adding loading status
        status = Status.loading;
        final available = await find<APIService>().api.checkUsername(username);
        if (available.isSuccessful) {
          // sending username available status
          _usernameChecked = true;
          _usernameError = false;
          _usernameMessage = "Username available";
          _usernameAvailable = true;
          _status = Status.loaded;
          notifyListeners();
          return;
        } else {
          // sending username unavailable status
          _status = Status.error;
          _usernameError = false;
          _usernameAvailable = false;
          _usernameChecked = true;
          _usernameMessage = "Username taken";
          notifyListeners();
          return;
        }
      }
    }
  }

  bool get usernameError => _usernameError;

  set usernameError(bool value) {
    _usernameError = value;
    notifyListeners();
  }

  bool get usernameChecked => _usernameChecked;

  set usernameChecked(bool value) {
    _usernameChecked = value;
    notifyListeners();
  }

  bool get usernameAvailable => _usernameAvailable;

  set usernameAvailable(bool value) {
    _usernameAvailable = value;
    notifyListeners();
  }

  String get usernameMessage => _usernameMessage;

  set usernameMessage(String value) {
    _usernameMessage = value;
    notifyListeners();
  }

  Status get status => _status;

  set status(Status value) {
    _status = value;
    notifyListeners();
  }
}
