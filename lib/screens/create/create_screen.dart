import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlomobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlomobx/components/error_box.dart';
import 'package:xlomobx/stores/create_store.dart';
import 'package:xlomobx/stores/page_store.dart';

import 'components/category_field.dart';
import 'components/cep_field.dart';
import 'components/hide_phone_field.dart';
import 'components/images_field.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final CreateStore createStore = CreateStore();

  @override
  void initState() {
    super.initState();

    // reaction((_) => createStore.savedAd, (ad) {
    //   if(ad != null) {
    //
    //   }
    // });

    when((_) => createStore.savedAd, () {
      GetIt.I<PageStore>().setPage(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.grey,
      fontSize: 18,
    );

    final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Criar Anuncio"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Observer(
              builder: (_) {
                if (createStore.loading)
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Salvando Anuncio',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.purple),
                        )
                      ],
                    ),
                  );
                else
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ImagesField(createStore),
                      Observer(builder: (_) {
                        return TextFormField(
                          onChanged: createStore.setTitle,
                          decoration: InputDecoration(
                            labelText: "Titulo *",
                            labelStyle: labelStyle,
                            contentPadding: contentPadding,
                            errorText: createStore.titleError,
                          ),
                        );
                      }),
                      Observer(builder: (_) {
                        return TextFormField(
                          onChanged: createStore.setDescription,
                          maxLength: 250,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "Descricacao *",
                            labelStyle: labelStyle,
                            contentPadding: contentPadding,
                            counterText: "",
                            errorText: createStore.descriptionError,
                          ),
                        );
                      }),
                      CategoryField(
                        createStore: createStore,
                      ),
                      CepField(
                        createStore: createStore,
                      ),
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            onChanged: createStore.setPrice,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              RealInputFormatter(
                                centavos: true,
                              )
                            ],
                            decoration: InputDecoration(
                                labelText: "Preco *",
                                labelStyle: labelStyle,
                                contentPadding: contentPadding,
                                prefixText: 'R\$ ',
                                errorText: createStore.priceError),
                          );
                        },
                      ),
                      HidePhoneField(
                        createStore: createStore,
                      ),
                      Observer(
                        builder: (_) {
                          return ErrorBox(message: createStore.error);
                        },
                      ),
                      Observer(
                        builder: (_) {
                          return SizedBox(
                            height: 50,
                            child: GestureDetector(
                              onTap: createStore.invalidSendPressed,
                              child: RaisedButton(
                                child: Text(
                                  'Enviar',
                                  style: TextStyle(fontSize: 18),
                                ),
                                textColor: Colors.white,
                                color: Colors.orange,
                                disabledColor: Colors.orange.withAlpha(120),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: createStore.sendPressed,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  );
              },
            ),
          ),
        ),
      ),
    );
  }
}
