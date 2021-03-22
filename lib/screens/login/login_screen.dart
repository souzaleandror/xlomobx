import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlomobx/components/error_box.dart';
import 'package:xlomobx/screens/signup/signup_screen.dart';
import 'package:xlomobx/stores/login_store.dart';
import 'package:xlomobx/stores/user_manager_store.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore loginStore = LoginStore();

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    when((_) => userManagerStore.userModel != null, () {
      Navigator.of(context).pop(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Observer(
                      builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ErrorBox(
                            message: loginStore.error,
                          ),
                        );
                      },
                    ),
                    Text(
                      'Acessar com Email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 4, bottom: 4, top: 8),
                      child: Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !loginStore.loading,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: loginStore.emailError),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: loginStore.setEmail,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Senha',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              'Esqueceu sua senha?',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.purple),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    Observer(
                      builder: (_) {
                        return TextField(
                          enabled: !loginStore.loading,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              isDense: true,
                              errorText: loginStore.pass1Error),
                          obscureText: true,
                          onChanged: loginStore.setPass1,
                        );
                      },
                    ),
                    Observer(
                      builder: (_) {
                        return Container(
                          height: 40,
                          margin: EdgeInsets.only(top: 20, bottom: 12),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.orange,
                            child: loginStore.loading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : Text('Entrar'),
                            textColor: Colors.white,
                            disabledColor: Colors.orange.withAlpha(120),
                            elevation: 0,
                            onPressed: loginStore.loginPressed,
                          ),
                        );
                      },
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            'Nao tem uma conta? ',
                            style: TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => SignUpScreen()));
                            },
                            child: Text(
                              'Cadastre-se',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.purple,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
