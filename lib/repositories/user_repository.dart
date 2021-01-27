import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlomobx/models/user_model.dart';
import 'package:xlomobx/repositories/parse_errors.dart';
import 'package:xlomobx/repositories/table_keys.dart';

class UserRepository {
  String name;
  String email;
  String phone;

  Future<UserModel> signUp(UserModel userModel) async {
    final parseUser =
        ParseUser(userModel.email, userModel.password, userModel.email);

    parseUser.set<String>(keyUserName, userModel.name);
    parseUser.set<String>(keyUserEmail, userModel.email);
    parseUser.set<String>(keyUserPhone, userModel.phone);
    parseUser.set(keyUserType, userModel.type.index);
    // parseUser.set<String>(KeyUserPassword, userModel.password);
    //parseUser.set<String>(KeyUserPassword2, userModel.password2);

    final response = await parseUser.signUp();

    if (response.success) {
      print(response.result);
      return mapParseToUserModel(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<UserModel> loginWithEmail(String email, String password) async {
    final parseUser = ParseUser(email, password, null);
    final response = await parseUser.login();

    if (response.success) {
      return mapParseToUserModel(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  UserModel mapParseToUserModel(ParseUser parseUser) {
    return UserModel(
        id: parseUser.objectId,
        name: parseUser.get(keyUserName),
        email: parseUser.get(keyUserEmail),
        phone: parseUser.get(keyUserPhone),
        type: UserType.values[parseUser.get(keyUserType)],
        createdAt: parseUser.get(keyUserCreatedAt));
  }

  Future<UserModel> currentUser() async {
    final parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      final response =
          await ParseUser.getCurrentUserFromServer(parseUser.sessionToken);
      if (response.success) {
        return mapParseToUserModel(response.result);
      } else {
        await parseUser.logout();
      }
    }

    return null;
  }

  Future<void> save(UserModel user) async {
    final parseUser = await ParseUser.currentUser();

    if (parseUser != null) {
      parseUser.set<String>(keyUserName, user.name);
      parseUser.set<String>(keyUserPhone, user.phone);
      parseUser.set<int>(keyUserType, user.type.index);

      if (user.password != null) {
        parseUser.password = user.password;
      }

      final response = await parseUser.save();

      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }

      if (user.password != null) {
        await parseUser.logout();

        final loginResponse =
            await ParseUser(user.email, user.password, '').login();

        if (!loginResponse.success) {
          return Future.error(ParseErrors.getDescription(response.error.code));
        }
      }
    }
  }

  Future<void> logout() async {
    final ParseUser currentUser = await ParseUser.currentUser();

    await currentUser.logout();
  }
}
