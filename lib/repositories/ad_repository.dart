import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as path;
import 'package:xlomobx/models/ad.dart';
import 'package:xlomobx/models/category.dart';
import 'package:xlomobx/models/user_model.dart';
import 'package:xlomobx/repositories/parse_errors.dart';
import 'package:xlomobx/repositories/table_keys.dart';
import 'package:xlomobx/stores/filter_store.dart';

class AdRepository {
  Future<List<Ad>> getHomeAdList({
    FilterStore filterStore,
    String search,
    Category category,
    int page,
  }) async {
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyAdTable));

    queryBuilder.includeObject([keyAdOwner, keyAdCategory]);

    queryBuilder.setAmountToSkip(page * 10);
    queryBuilder.setLimit(10);

    queryBuilder.whereEqualTo(keyAdStatus, AdStatus.ACTIVE.index);

    if (search != null && search.trim().isNotEmpty) {
      queryBuilder.whereContains(keyAdTitle, search, caseSensitive: false);

      if (category != null && category.id != '*') {
        queryBuilder.whereEqualTo(
            keyAdCategory,
            (ParseObject(keyCategoryTable)..set(keyCategoryId, category.id))
                .toPointer());
      }
    }

    switch (filterStore.orderBy) {
      case OrderBy.PRICE:
        queryBuilder.orderByAscending(keyAdPrice);
        break;
      case OrderBy.DATE:
      default:
        queryBuilder.orderByDescending(keyAdCreatedAt);
        break;
    }

    if (filterStore.minPrice != null && filterStore.minPrice > 0) {
      queryBuilder.whereGreaterThanOrEqualsTo(keyAdPrice, filterStore.minPrice);
    }

    if (filterStore.maxPrice != null && filterStore.maxPrice > 0) {
      queryBuilder.whereLessThanOrEqualTo(keyAdPrice, filterStore.maxPrice);
    }

    if (filterStore.vendorType != null &&
        filterStore.vendorType > 0 &&
        filterStore.vendorType <
            (VENDOR_TYPE_PARTICULAR | VENDOR_TYPE_PROFESSIONAL)) {
      final userQuery = QueryBuilder<ParseUser>(ParseUser.forQuery());

      if (filterStore.vendorType == VENDOR_TYPE_PARTICULAR) {
        userQuery.whereEqualTo(keyUserType, UserType.PARTICULAR.index);
      }

      if (filterStore.vendorType == VENDOR_TYPE_PROFESSIONAL) {
        userQuery.whereEqualTo(keyUserType, UserType.PROFESSIONAL.index);
      }

      queryBuilder.whereMatchesQuery(keyAdOwner, userQuery);
    }

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      return response.results.map((po) => Ad.fromParse(po)).toList();
    } else if (response.success && response.results == null) {
      return [];
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> save(Ad ad) async {
    try {
      final parseImages = await saveImages(ad.images);

      final parseUser = ParseUser('', '', '')..set(keyUserId, ad.user.id);

      final adObject = ParseObject(keyAdTable);
      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);
      adObject.setACL(parseAcl);

      adObject.set<String>(keyAdTitle, ad.title);
      adObject.set<String>(keyAdDescription, ad.description);
      adObject.set<bool>(keyAdHidePhone, ad.hidePhone);
      adObject.set<num>(keyAdPrice, ad.price);
      adObject.set<int>(keyAdStatus, ad.status.index);

      adObject.set<String>(keyAdDistrict, ad.address.district);
      adObject.set<String>(keyAdCity, ad.address.city.name);
      adObject.set<String>(keyAdFederativeUnit, ad.address.uf.initials);
      adObject.set<String>(keyAdPostalCode, ad.address.cep);
      adObject.set<List<ParseFile>>(keyAdImages, parseImages);
      adObject.set<ParseUser>(keyAdOwner, parseUser);

      adObject.set<ParseObject>(keyAdCategory,
          ParseObject(keyCategoryTable)..set(keyCategoryId, ad.category.id));

      final response = await adObject.save();

      if (response.success) {
        //return Ad.fromParse(response.result);
        return;
      } else {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    } catch (e, ex) {
      debugPrint("$e >>> $ex");
      return Future.error('Falha ao salvar o anuncio');
    }
  }

  Future<List<ParseFile>> saveImages(List images) async {
    final parseImages = <ParseFile>[];

    try {
      for (final image in images) {
        if (image is File) {
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile.save();

          if (!response.success) {
            return Future.error(
                ParseErrors.getDescription(response.error.code));
          }
          parseImages.add(parseFile);
        } else {
          final parseFile = ParseFile(null);
          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        }
      }
      return parseImages;
    } catch (e, ex) {
      debugPrint("$e >>> $ex");
      return Future.error('Falha ao subir imagens');
    }
  }
}
