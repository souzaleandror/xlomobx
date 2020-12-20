import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:xlomobx/models/address.dart';
import 'package:xlomobx/models/city.dart';
import 'package:xlomobx/repositories/ibge_repository.dart';

class CepRepository {
  Future<Address> getAddressFromApi(String cep) async {
    if (cep == null || cep.isEmpty) return Future.error('CEP Invalido');

    final clearCEP = cep.replaceAll(RegExp('[^0-9]'), '');

    if (clearCEP.length != 8) return Future.error('CEP Invalido');

    final String endpoint = 'https://viacep.com.br/ws/$clearCEP/json';

    try {
      final response = await Dio().get<Map>(endpoint);

      if (response.data.containsKey('erro') && response.data['erro'])
        return Future.error('CEP Invalido');

      final ufList = await IBGERepository().getUFListFromApi();

      return Address(
        uf: ufList.firstWhere((uf) => uf.initials == response.data['uf']),
        city: City(name: response.data['localidade']),
        district: response.data['bairro'] ?? '',
        cep: response.data['cep'] ?? '',
        clearCep: clearCEP ?? '',
        logradouro: response.data['logradouro'] ?? '',
        bairro: response.data['bairro'] ?? '',
        complemento: response.data['complemento'] ?? '',
        localidade: response.data['localidade'] ?? '',
        uuf: response.data['uf'] ?? '',
        ibge: response.data['ibge'] ?? '',
        gia: response.data['gia'] ?? '',
        ddd: response.data['ddd'] ?? '',
        siafi: response.data['siafi'] ?? '',
      );
    } catch (e, ex) {
      debugPrint("$e >>> $ex");
      return Future.error('Falha ao buscar CEP');
    }
  }
}
