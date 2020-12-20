import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlomobx/helpers/extensions.dart';
import 'package:xlomobx/models/user_model.dart';
import 'package:xlomobx/repositories/user_repository.dart';
import 'package:xlomobx/stores/user_manager_store.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {
  _SignupStore() {
    autorun((_) {
      print(name);
      print(email);
      print(phone);
      print(pass1);
      print(pass2);
      print(isFormValid);
      print(loading);
    });
  }

  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @computed
  //Name
  bool get nameValid => name != null && name.length > 3;
  String get nameError {
    if (name == null || nameValid) {
      return null;
    } else if (name.isEmpty) {
      return 'Campo obrigatorio';
    } else {
      return 'Nome muito curto';
    }
  }

  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError {
    if (email == null || emailValid) {
      return null;
    } else if (email.isEmpty) {
      return 'Campo obrigatorio';
    } else {
      return 'Email invaliado';
    }
  }

  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone.length >= 14;
  String get phoneError {
    if (phone == null || phoneValid) {
      return null;
    } else if (email.isEmpty) {
      return 'Campo obrigatorio';
    } else {
      return 'Celular invaliado';
    }
  }

  @observable
  String pass1;

  @action
  void setPass1(String value) => pass1 = value;

  @computed
  bool get pass1Valid => pass1 != null && pass1.length >= 6;
  String get pass1Error {
    if (pass1 == null || pass1Valid) {
      return null;
    } else if (pass1.isEmpty) {
      return 'Campo obrigatorio';
    } else {
      return 'Senha invalida invaliado';
    }
  }

  @observable
  String pass2;

  @action
  void setPass2(String value) => pass2 = value;

  @computed
  bool get pass2Valid => pass2 != null && pass2 == pass1;
  String get pass2Error {
    if (pass2 == null || pass2Valid) {
      return null;
    } else {
      return 'Senhas nao coincidem';
    }
  }

  @computed
  bool get isFormValid =>
      nameValid && emailValid && phoneValid && pass1Valid && pass2Valid;

  @computed
  Function get signUpPressed => (isFormValid && !loading) ? _signUp : null;

  @observable
  bool loading = false;

  @observable
  String error = '';

  Future<void> _signUp() async {
    loading = true;

    UserModel userModel = UserModel(
      name: name,
      email: email,
      password: pass1,
      password2: pass2,
    );

    try {
      error = null;
      final resultUser = await UserRepository().signUp(userModel);
      GetIt.I<UserManagerStore>().setUser(resultUser);
      print(resultUser);
    } catch (e, ex) {
      debugPrint("$e >>> $ex");
      error = e;
    }

    // await Future.delayed(Duration(seconds: 3));

    loading = false;
  }
}
