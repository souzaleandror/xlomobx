import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlomobx/screens/filter/components/price_field.dart';
import 'package:xlomobx/screens/filter/components/section_title.dart';
import 'package:xlomobx/stores/filter_store.dart';

class PriceRangeField extends StatelessWidget {
  PriceRangeField({Key key, this.filterStore}) : super(key: key);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Preco'),
        Row(
          children: [
            PriceField(
              label: 'Min',
              onChanged: filterStore.setMinPrice,
              initialValue: filterStore.minPrice,
            ),
            const SizedBox(
              width: 12,
            ),
            PriceField(
              label: 'Max',
              onChanged: filterStore.setMaxPrice,
              initialValue: filterStore.maxPrice,
            ),
          ],
        ),
        Observer(builder: (_) {
          if (filterStore.priceError != null) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                filterStore.priceError,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            );
          }
          return Container();
        }),
      ],
    );
  }
}
