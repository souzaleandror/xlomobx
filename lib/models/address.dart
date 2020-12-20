import 'package:xlomobx/models/city.dart';
import 'package:xlomobx/models/uf.dart';

class Address {
  UF uf;
  City city;

  String district;
  String cep;
  String clearCep;

  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uuf;
  String ibge;
  String gia;
  String ddd;
  String siafi;

  Address(
      {this.uf,
      this.city,
      this.district,
      this.cep,
      this.clearCep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uuf,
      this.ibge,
      this.gia,
      this.ddd,
      this.siafi});

  @override
  String toString() {
    return 'Address{uf: $uf, city: $city, district: $district, cep: $cep, clearCep: $clearCep, logradouro: $logradouro, complemento: $complemento, bairro: $bairro, localidade: $localidade, uuf: $uuf, ibge: $ibge, gia: $gia, ddd: $ddd, siafi: $siafi}';
  }

// {
  // "cep": "05547-110",
  // "logradouro": "Rua Anaxágoras",
  // "complemento": "",
  // "bairro": "Jardim Rosa Maria",
  // "localidade": "São Paulo",
  // "uf": "SP",
  // "ibge": "3550308",
  // "gia": "1004",
  // "ddd": "11",
  // "siafi": "7107"
  // }
  // https://viacep.com.br/ws/05547110/json
}
