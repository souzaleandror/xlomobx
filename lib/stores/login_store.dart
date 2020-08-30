import 'package:mobx/mobx.dart';
import 'package:xlomobx/helpers/extensions.dart';
import 'package:xlomobx/repositories/user_repository.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
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
  String pass1;

  @action
  void setPass1(String value) => pass1 = value;

  @computed
  bool get pass1Valid => pass1 != null && pass1.length >= 6;
  String get pass1Error {
    pass1 == null || pass1Valid ? null : 'Senha nao valida';
  }

  @computed
  Function get loginPressed => emailValid && pass1Valid ? _login : null;

  @observable
  bool loading = false;

  @observable
  String error;

  @action
  Future<void> _login() async {
    loading = true;

    try {
      error = null;
      final resultUser = await UserRepository().loginWithEmail(email, pass1);
      print(resultUser);
    } catch (e, ex) {
      error = e;
    }

    // await Future.delayed(Duration(seconds: 3));

    loading = false;
  }
}
