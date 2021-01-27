import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlomobx/helpers/extensions.dart';
import 'package:xlomobx/models/ad.dart';
import 'package:xlomobx/screens/ad/ad_screen.dart';
import 'package:xlomobx/screens/create/create_screen.dart';
import 'package:xlomobx/stores/myads_store.dart';

class ActiveTile extends StatelessWidget {
  ActiveTile(this.ad, this.store);

  final Ad ad;
  final MyAdsStore store;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar', iconData: Icons.edit),
    MenuChoice(index: 1, title: 'Ja Vendi', iconData: Icons.thumb_up),
    MenuChoice(index: 2, title: 'Excluir', iconData: Icons.delete),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AdScreen(
              ad: ad,
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        child: Container(
          height: 80,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: ad.images.isNotEmpty
                      ? ad.images.first
                      : "data:image/jpeg;base64,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",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${ad.title}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${ad.price.formattedMoney()}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${ad.views} visitas',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  PopupMenuButton<MenuChoice>(
                    onSelected: (choice) {
                      switch (choice.index) {
                        case 0:
                          editAd(context);
                          break;
                        case 1:
                          soldAd(context);
                          break;
                        case 2:
                          deleteAd(context);
                          break;
                      }
                    },
                    icon: Icon(
                      Icons.more_vert,
                      size: 20,
                      color: Colors.purple,
                    ),
                    itemBuilder: (_) {
                      return choices
                          .map(
                            (choice) => PopupMenuItem<MenuChoice>(
                              value: choice,
                              child: Row(
                                children: [
                                  Icon(
                                    choice.iconData,
                                    size: 20,
                                    color: Colors.purple,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    choice.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.purple,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editAd(BuildContext context) async {
    final success = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => CreateScreen(ad: ad)));

    if (success != null && success) {
      store.refresh();
    }
  }

  void soldAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Vendido'),
        content: Text('Confirmar a venda de ${ad.title} ?'),
        actions: [
          FlatButton(
            onPressed: Navigator.of(context).pop,
            child: Text(
              'Nao',
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              store.soldAd(ad);
            },
            child: Text(
              'Sim',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deleteAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Deletar'),
        content: Text('Confirmar para excluir ${ad.title} ?'),
        actions: [
          FlatButton(
            onPressed: Navigator.of(context).pop,
            child: Text(
              'Nao',
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              store.deleteAd(ad);
            },
            child: Text(
              'Sim',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuChoice {
  MenuChoice({this.index, this.title, this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
