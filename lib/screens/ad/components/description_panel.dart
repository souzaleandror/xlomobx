import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:xlomobx/models/ad.dart';

class DescriptionPanel extends StatelessWidget {
  DescriptionPanel({Key key, this.ad}) : super(key: key);

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
            'Descricao',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
          ),
          child: ReadMoreText(
            ad.description,
            trimLines: 3,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Ver Descricao completa',
            trimExpandedText: '...menos',
            colorClickableText: Colors.purple,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
