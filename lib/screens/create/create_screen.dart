import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlomobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlomobx/stores/create_store.dart';

import 'components/images_field.dart';

class CreateScreen extends StatelessWidget {
  CreateStore createStore = CreateStore();

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
      body: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImagesField(createStore),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Titulo *",
                labelStyle: labelStyle,
                contentPadding: contentPadding,
              ),
            ),
            TextFormField(
              maxLength: 250,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Descricaco *",
                labelStyle: labelStyle,
                contentPadding: contentPadding,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
