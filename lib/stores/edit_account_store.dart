import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlomobx/models/user_model.dart';
import 'package:xlomobx/repositories/user_repository.dart';
import 'package:xlomobx/stores/user_manager_store.dart';

part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {
  _EditAccountStore() {
    user = userManagerStore.userModel;

    userType = user.type;
    name = user.name;
    phone = user.phone;
  }

  UserModel user;

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @observable
  UserType userType;

  @action
  void setUserType(int value) => userType = UserType.values[value];

  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name.length >= 6;
  String get nameError =>
      nameValid || name == null ? null : 'Campo Obrigatorio';

  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone.length >= 14;
  String get phoneError =>
      phoneValid || phone == null ? null : 'Campo Obrigatorio';

  @observable
  String pass1 = '';

  @action
  void setPass1(String value) => pass1 = value;

  @observable
  String pass2 = '';

  @action
  void setPass2(String value) => pass2 = value;

  @computed
  bool get passValid => pass2 == pass1 && (pass1.length >= 6 || pass1.isEmpty);
  String get passError {
    if (pass1.isNotEmpty && pass1.length < 6) {
      return 'Senha muito curta';
    } else if (pass1 != pass2) {
      return 'Senhas nao coincidem';
    }
    return null;
  }

  @computed
  bool get isFormValid => nameValid && phoneValid && passValid;

  @observable
  bool loading = false;

  @computed
  VoidCallback get savePressed => (isFormValid && !loading) ? _save : null;

  @action
  Future<void> _save() async {
    loading = true;

    user.name = name;
    user.phone = phone;
    user.type = userType;

    if (pass1.isNotEmpty) {
      user.password = pass1;
    } else {
      user.password = null;
    }

    try {
      await UserRepository().save(user);
      userManagerStore.setUser(user);
    } catch (e, ex) {
      print("$e >>> $ex");
    }

    //await Future.delayed(Duration(seconds: 4));

    loading = false;
  }

  void logout() => userManagerStore.logout();
}
