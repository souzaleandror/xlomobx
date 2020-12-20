import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlomobx/stores/cep_store.dart';
import 'package:xlomobx/stores/create_store.dart';

class CepField extends StatelessWidget {
  CepField({Key key, this.createStore})
      : cepStore = createStore.cepStore,
        super(key: key);

  final CreateStore createStore;
  final CepStore cepStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Observer(builder: (_) {
          return TextFormField(
            onChanged: cepStore.setCep,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter()
            ],
            decoration: InputDecoration(
                labelText: 'CEP',
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey,
                ),
                errorText: createStore.addressError,
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10)),
          );
        }),
        Observer(
          builder: (_) {
            if (cepStore.error == null &&
                cepStore.address == null &&
                !cepStore.loading) {
              return Container();
            } else if (cepStore.address == null && cepStore.error == null) {
              return LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.purple),
                backgroundColor: Colors.transparent,
              );
            } else if (cepStore.error != null) {
              return Container(
                color: Colors.red.withAlpha(100),
                height: 50,
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  cepStore.error,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              );
            } else {
              final a = cepStore.address;
              return Container(
                color: Colors.purple.withAlpha(150),
                height: 50,
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  'Localizacao: ${a.district}, ${a.city.name} - ${a.uuf}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
