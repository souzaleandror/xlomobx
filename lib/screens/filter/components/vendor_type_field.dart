import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlomobx/screens/filter/components/section_title.dart';
import 'package:xlomobx/stores/filter_store.dart';

class VendorTypeField extends StatelessWidget {
  VendorTypeField({Key key, this.filterStore}) : super(key: key);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle(title: 'Tipo de anunciante'),
        Observer(builder: (_) {
          return Wrap(
            runSpacing: 4,
            children: [
              GestureDetector(
                onTap: () {
                  if (filterStore.isTypeParticular) {
                    if (filterStore.isTypeProfessional) {
                      filterStore.resetVendorType(VENDOR_TYPE_PARTICULAR);
                    } else {
                      filterStore.setVendorType(VENDOR_TYPE_PROFESSIONAL);
                    }
                  } else {
                    filterStore.setVendorType(VENDOR_TYPE_PARTICULAR);
                  }
                },
                child: Container(
                  height: 50,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: filterStore.isTypeParticular
                        ? Colors.purple
                        : Colors.transparent,
                    border: Border.all(
                      color: filterStore.isTypeParticular
                          ? Colors.purple
                          : Colors.black,
                    ),
                  ),
                  alignment: Alignment.center,

                  child: Text(
                    'Particular',
                    style: TextStyle(
                        color: filterStore.isTypeParticular
                            ? Colors.white
                            : Colors.purple),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              GestureDetector(
                onTap: () {
                  if (filterStore.isTypeProfessional) {
                    if (filterStore.isTypeParticular) {
                      filterStore.resetVendorType(VENDOR_TYPE_PROFESSIONAL);
                    } else {
                      filterStore.setVendorType(VENDOR_TYPE_PARTICULAR);
                    }
                  } else {
                    filterStore.setVendorType(VENDOR_TYPE_PROFESSIONAL);
                  }
                },
                child: Container(
                  height: 50,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: filterStore.isTypeProfessional
                        ? Colors.purple
                        : Colors.transparent,
                    border: Border.all(
                      color: filterStore.isTypeProfessional
                          ? Colors.purple
                          : Colors.black,
                    ),
                  ),
                  alignment: Alignment.center,

                  child: Text(
                    'Professional',
                    style: TextStyle(
                      color: filterStore.isTypeProfessional
                          ? Colors.white
                          : Colors.purple,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
