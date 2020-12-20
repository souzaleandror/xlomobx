import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlomobx/screens/filter/components/section_title.dart';
import 'package:xlomobx/stores/filter_store.dart';

class OrderByField extends StatelessWidget {
  OrderByField({Key key, this.filterStore}) : super(key: key);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    Widget buildOption({String title, OrderBy option}) {
      return GestureDetector(
        onTap: () {
          filterStore.setOrderBy(option);
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: filterStore.orderBy == option
                ? Colors.purple
                : Colors.transparent,
            border: Border.all(
              color:
                  filterStore.orderBy == option ? Colors.purple : Colors.black,
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color:
                  filterStore.orderBy == option ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionTitle(
          title: 'Ordernar por',
        ),
        Observer(
          builder: (_) {
            return Row(
              children: [
                buildOption(
                  title: 'Data',
                  option: OrderBy.DATE,
                ),
                const SizedBox(
                  width: 12,
                ),
                buildOption(
                  title: 'Preco',
                  option: OrderBy.PRICE,
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
