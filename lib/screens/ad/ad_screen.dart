import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:xlomobx/models/ad.dart';
import 'package:xlomobx/screens/ad/components/bottom_bar.dart';
import 'package:xlomobx/screens/ad/components/user_panel.dart';

import 'components/description_panel.dart';
import 'components/location_panel.dart';
import 'components/main_panel.dart';

class AdScreen extends StatelessWidget {
  AdScreen({Key key, this.ad}) : super(key: key);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Anuncio'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: 280,
                width: double.infinity,
                child: Carousel(
                  boxFit: BoxFit.contain,
                  images: ad.images
                      .map(
                        (url) => CachedNetworkImage(
                          imageUrl: url,
                        ),
                      )
                      .toList(),
                  dotSize: 4,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.orange,
                  autoplay: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MainPanel(
                      ad: ad,
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    DescriptionPanel(
                      ad: ad,
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    LocationPanel(
                      ad: ad,
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    UserPanel(
                      ad: ad,
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    SizedBox(
                      height: ad.status == AdStatus.PENDING ? 16 : 120,
                    ),
                  ],
                ),
              )
            ],
          ),
          BottomBar(ad),
        ],
      ),
    );
  }
}
