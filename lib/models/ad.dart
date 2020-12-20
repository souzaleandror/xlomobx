import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlomobx/models/address.dart';
import 'package:xlomobx/models/category.dart';
import 'package:xlomobx/models/city.dart';
import 'package:xlomobx/models/uf.dart';
import 'package:xlomobx/models/user_model.dart';
import 'package:xlomobx/repositories/table_keys.dart';
import 'package:xlomobx/repositories/user_repository.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETED }

class Ad {
  String id;
  List images;
  String title;
  String description;
  Category category;
  Address address;
  num price;
  bool hidePhone;
  AdStatus status = AdStatus.PENDING;
  DateTime cratedDated;

  //DateTime updatedDated;
  UserModel user;
  int views;

  Ad();

  Ad.fromParse(ParseObject object) {
    id = object.objectId;
    title = object.get<String>(keyAdTitle);
    description = object.get<String>(keyAdDescription);
    images = object.get<List>(keyAdImages).map((e) => e.url).toList();
    hidePhone = object.get<bool>(keyAdHidePhone);
    price = object.get<num>(keyAdPrice);
    cratedDated = object.createdAt;
    address = Address(
      district: object.get<String>(keyAdDistrict),
      city: City(name: object.get<String>(keyAdCity)),
      cep: object.get<String>(keyAdPostalCode),
      uf: UF(initials: object.get<String>(keyAdFederativeUnit)),
    );
    views = object.get<int>(keyAdViews, defaultValue: 0);
    user =
        UserRepository().mapParseToUserModel(object.get<ParseUser>(keyAdOwner));
    category = Category.fromParse(object.get<ParseObject>(keyAdCategory));
    status = AdStatus.values[object.get<int>(keyAdStatus)];
  }
}
