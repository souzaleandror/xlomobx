import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:xlomobx/stores/edit_account_store.dart';
import 'package:xlomobx/stores/page_store.dart';

class EditAccountScreen extends StatelessWidget {
  final EditAccountStore store = EditAccountStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Observer(
                    builder: (_) {
                      return IgnorePointer(
                        ignoring: store.loading,
                        child: LayoutBuilder(
                          builder: (_, constraints) {
                            return ToggleSwitch(
                              minWidth: constraints.biggest.width / 2.01,
                              labels: [
                                'Particular',
                                'Professional',
                              ],
                              cornerRadius: 20,
                              activeBgColor: Colors.purple,
                              inactiveBgColor: Colors.grey,
                              activeFgColor: Colors.white,
                              inactiveFgColor: Colors.white,
                              initialLabelIndex: store.userType.index,
                              onToggle: store.setUserType,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Observer(
                    builder: (_) {
                      return TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          labelText: 'Nome*',
                          errorText: store.nameError,
                        ),
                        onChanged: store.setName,
                        initialValue: store.name,
                        enabled: !store.loading,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Observer(
                    builder: (_) {
                      return TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          labelText: 'Telefone*',
                          errorText: store.phoneError,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        onChanged: store.setPhone,
                        initialValue: store.phone,
                        enabled: !store.loading,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Observer(builder: (_) {
                    return TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Nova Senha',
                      ),
                      obscureText: true,
                      onChanged: store.setPass1,
                      enabled: !store.loading,
                    );
                  }),
                  const SizedBox(
                    height: 8,
                  ),
                  Observer(
                    builder: (_) {
                      return TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          labelText: 'Confirmar Nova Senha',
                          errorText: store.passError,
                        ),
                        obscureText: true,
                        onChanged: store.setPass2,
                        enabled: !store.loading,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Observer(
                    builder: (_) {
                      return SizedBox(
                        height: 40,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: store.savePressed,
                          color: Colors.orange,
                          disabledColor: Colors.orange.withAlpha(100),
                          child: store.loading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                    Colors.white,
                                  ),
                                )
                              : Text(
                                  'Salvar',
                                  style: TextStyle(color: Colors.white),
                                ),
                          elevation: 0,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        store.logout();
                        GetIt.I<PageStore>().setPage(0);
                        Navigator.of(context).pop();
                      },
                      color: Colors.red,
                      child: Text(
                        'Sair',
                        style: TextStyle(color: Colors.white),
                      ),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
