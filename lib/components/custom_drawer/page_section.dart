import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlomobx/components/custom_drawer/page_tile.dart';
import 'package:xlomobx/screens/login/login_screen.dart';
import 'package:xlomobx/stores/page_store.dart';
import 'package:xlomobx/stores/user_manager_store.dart';

class PageSection extends StatelessWidget {
  final PageStore pageStore = GetIt.I<PageStore>();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    Future<void> verifyLoginAndSetPage(int page) async {
      if (userManagerStore.isLoggedIn) {
        pageStore.setPage(page);
      } else {
        final result = await Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LoginScreen()));
        if (result != null && result) pageStore.setPage(page);
      }
    }

    return Column(
      children: [
        PageTile(
          label: 'Anuncios',
          iconData: Icons.list,
          onTap: () {
            verifyLoginAndSetPage(0);
          },
          highlighted: pageStore.page == 0,
        ),
        PageTile(
          label: 'Inserir anuncio',
          iconData: Icons.edit,
          onTap: () {
            verifyLoginAndSetPage(1);
          },
          highlighted: pageStore.page == 1,
        ),
        PageTile(
          label: 'Chat',
          iconData: Icons.chat,
          onTap: () {
            verifyLoginAndSetPage(2);
          },
          highlighted: pageStore.page == 2,
        ),
        PageTile(
          label: 'Favoritos',
          iconData: Icons.favorite,
          onTap: () {
            verifyLoginAndSetPage(3);
          },
          highlighted: pageStore.page == 3,
        ),
        PageTile(
          label: 'Minha conta',
          iconData: Icons.person,
          onTap: () {
            verifyLoginAndSetPage(4);
          },
          highlighted: pageStore.page == 4,
        ),
      ],
    );
  }
}
