import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlomobx/components/empty_card.dart';
import 'package:xlomobx/screens/myads/components/pending_tile.dart';
import 'package:xlomobx/stores/myads_store.dart';

import 'components/active_tile.dart';
import 'components/sold_tile.dart';

class MyAdsScreen extends StatefulWidget {
  final int initialPage;

  MyAdsScreen({this.initialPage = 0});

  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  final MyAdsStore store = MyAdsStore();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Anuncios'),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.orange,
          tabs: [
            Tab(
              child: Text('ATIVOS'),
            ),
            Tab(
              child: Text('PENDENTES'),
            ),
            Tab(
              child: Text('VENDIDOS'),
            ),
          ],
        ),
      ),
      body: Observer(builder: (_) {
        if (store.loading == true)
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
          );

        return TabBarView(
          controller: tabController,
          children: [
            Observer(builder: (_) {
              if (store.activeAds.isEmpty)
                return EmptyCard('Voce nao possui nenhum anuncio ativo');

              return ListView.builder(
                itemCount: store.activeAds.length,
                itemBuilder: (_, index) {
                  return ActiveTile(store.activeAds[index], store);
                },
              );
            }),
            Observer(builder: (_) {
              if (store.pendingAds.isEmpty)
                return EmptyCard('Voce nao possui nenhum anuncio pendente');

              return ListView.builder(
                itemCount: store.pendingAds.length,
                itemBuilder: (_, index) {
                  return PendingTile(store.pendingAds[index]);
                },
              );
            }),
            Observer(builder: (_) {
              if (store.soldAds.isEmpty)
                return EmptyCard('Voce nao possui nenhum anuncio vendido');

              return ListView.builder(
                itemCount: store.soldAds.length,
                itemBuilder: (_, index) {
                  return SoldTile(store.soldAds[index], store);
                },
              );
            }),
          ],
        );
      }),
    );
  }
}
