import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlomobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlomobx/screens/edit_account/edit_account_screen.dart';
import 'package:xlomobx/screens/myads/myads_screen.dart';
import 'package:xlomobx/stores/user_manager_store.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Conta'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 140,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Observer(
                            builder: (_) {
                              return Text(
                                GetIt.I<UserManagerStore>().userModel.name,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.purple,
                                    fontWeight: FontWeight.w900),
                              );
                            },
                          ),
                          Text(
                            GetIt.I<UserManagerStore>().userModel.email,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: FlatButton(
                        child: Text(
                          'EDITAR',
                        ),
                        textColor: Colors.purple,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => EditAccountScreen(),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Meus Anuncios',
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MyAdsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Favoritos',
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                ),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
