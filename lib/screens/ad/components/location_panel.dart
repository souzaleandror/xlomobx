import 'package:flutter/material.dart';
import 'package:xlomobx/models/ad.dart';

class LocationPanel extends StatelessWidget {
  LocationPanel({Key key, this.ad}) : super(key: key);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 18,
          ),
          child: Text(
            'Location',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 18,
            bottom: 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cep'),
                    const SizedBox(
                      height: 12,
                    ),
                    Text('Cidade'),
                    const SizedBox(
                      height: 12,
                    ),
                    Text('Bairro'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${ad.address.cep}'),
                    const SizedBox(
                      height: 12,
                    ),
                    Text('${ad.address.city.name}'),
                    const SizedBox(
                      height: 12,
                    ),
                    Text('${ad.address.district}'),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
