import 'package:parse_server_sdk/parse_server_sdk.dart';
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

    parseUser.set<String>(KeyUserName, userModel.name);
    parseUser.set<String>(KeyUserEmail, userModel.email);
    parseUser.set<String>(KeyUserPhone, userModel.phone);
    parseUser.set(KeyUserType, userModel.type.index);
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
        name: parseUser.get(KeyUserName),
        email: parseUser.get(KeyUserEmail),
        phone: parseUser.get(KeyUserPhone),
        type: UserType.values[parseUser.get(KeyUserType)],
        createdAt: parseUser.get(KeyUserCreatedAt));
  }
}