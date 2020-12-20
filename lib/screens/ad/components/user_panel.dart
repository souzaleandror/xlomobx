import 'package:flutter/material.dart';
import 'package:xlomobx/helpers/extensions.dart';
import 'package:xlomobx/models/ad.dart';

class UserPanel extends StatelessWidget {
  UserPanel({Key key, this.ad}) : super(key: key);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 10,
          ),
          child: Text(
            'Anunciante',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ad.user.name,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(ad.user.createdAt.formattedDate())
            ],
          ),
        )
      ],
    );
  }
}
