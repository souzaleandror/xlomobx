import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:xlomobx/models/address.dart';
import 'package:xlomobx/repositories/cep_repository.dart';

part 'cep_store.g.dart';

class CepStore = _CepStore with _$CepStore;

abstract class _CepStore with Store {
  _CepStore(String initialCep) {
    autorun((_) {
      if (clearCep.length != 8) {
        _reset();
      } else {
        _searchCep();
      }
    });

    setCep(initialCep);
  }

  @observable
  String cep = '';

  @action
  void setCep(String value) => cep = value;

  @computed
  String get clearCep => cep.replaceAll(RegExp('[^0-9]'), '');

  @observable
  Address address;

  @observable
  String error;

  @observable
  bool loading = false;

  Future<void> _searchCep() async {
    loading = true;
    try {
      address = await CepRepository().getAddressFromApi(clearCep);
      error = null;
    } catch (e, ex) {
      debugPrint("$e >>> $ex");
      error = e;
      address = null;
    }
    loading = false;
  }

  @action
  void _reset() {
    address = null;
    error = null;
  }
}
