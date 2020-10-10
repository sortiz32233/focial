import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:focial/models/user.dart';
import 'package:focial/services/api.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/utils/overlays.dart';
import 'package:ots/ots.dart';

enum Status { idle, loading, loaded, error }

class UserData extends ChangeNotifier {
  User _currentUser = User();
  Status _status = Status.idle;

  void init() {
    if (_currentUser != null && _currentUser.firstName != null && _currentUser.email != null) {
      status = Status.loaded;
    }
  }

  Future<void> fetchUser() async {
    if (status == Status.loading || status == Status.loaded) return;
    status = Status.loading;
    final response = await find<APIService>().api.getUser();
    if (response.isSuccessful) {
      _currentUser = User.fromJson(response.body["user"] as Map<String, dynamic>);
      _status = Status.loaded;
      notifyListeners();
    } else {
      debugPrint("User data can't be loaded ${response.error}");
      status = Status.error;
    }
  }

  Future<Response> updateUserProfile(User user) async {
    _currentUser = user;
    _status = Status.loading;
    notifyListeners();
    final response = await find<APIService>().api.updateUser(user.toJson());
    if (response.isSuccessful) {
      _status = Status.loaded;
      notifyListeners();
    }
    return response;
  }

  Future<void> updateProfilePicture(String filePath) async {
    showLoader(isModal: true);
    status = Status.loading;
    final response = await find<APIService>().api.uploadProfilePicture(filePath);

    if (response.isSuccessful) {
      _updatePhotoUrl(response.body["photoUrl"].toString());
      AppOverlays.showSuccess("Server response", "Profile picture uploaded");
    } else {
      AppOverlays.showError("Server response", 'Unable to update user picture, please try later');
      status = Status.loaded;
    }
    hideLoader();
  }

  Future<void> updateCoverPicture(String filePath) async {
    showLoader(isModal: true);
    status = Status.loading;
    final response = await find<APIService>().api.uploadCoverPicture(filePath);
    if (response.isSuccessful) {
      _updateCoverPic(response.body["photoUrl"].toString());
      AppOverlays.showSuccess("Server response", "Cover picture uploaded");
    } else {
      AppOverlays.showError("Server response", 'Unable to update user picture, please try later');
      status = Status.loaded;
    }
    hideLoader();
  }

  void _updatePhotoUrl(String photoUrl) {
    _currentUser.photoUrl = photoUrl;
    _status = Status.loaded;
    notifyListeners();
  }

  void _updateCoverPic(String photoUrl) {
    _currentUser.coverPic = photoUrl;
    _status = Status.loaded;
    notifyListeners();
  }

  Status get status => _status;

  set status(Status value) {
    _status = value;
    notifyListeners();
  }

  User get currentUser => _currentUser;

  set currentUser(User value) {
    _currentUser = value;
    notifyListeners();
  }
}
