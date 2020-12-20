import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlomobx/screens/filter/components/order_by_field.dart';
import 'package:xlomobx/stores/filter_store.dart';
import 'package:xlomobx/stores/home_store.dart';

import 'components/price_range_field.dart';
import 'components/vendor_type_field.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({Key key}) : super(key: key);

  final FilterStore filterStore = GetIt.I<HomeStore>().clonedFilter;

  @override
  Widget build(BuildContext context) {
    debugPrint(filterStore.orderBy.toString());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Filtrar Busca'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                OrderByField(
                  filterStore: filterStore,
                ),
                PriceRangeField(filterStore: filterStore),
                VendorTypeField(filterStore: filterStore),
                Observer(builder: (_) {
                  return Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: RaisedButton(
                      onPressed: filterStore.isFormValid
                          ? () {
                              filterStore.save();
                              Navigator.of(context).pop();
                            }
                          : null,
                      color: Colors.orange,
                      textColor: Colors.white,
                      disabledColor: Colors.orange.withAlpha(120),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(
                        'FILTRAR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
