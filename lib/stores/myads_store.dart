import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlomobx/models/ad.dart';
import 'package:xlomobx/repositories/ad_repository.dart';
import 'package:xlomobx/stores/user_manager_store.dart';

part 'myads_store.g.dart';

class MyAdsStore = _MyAdsStore with _$MyAdsStore;

abstract class _MyAdsStore with Store {
  _MyAdsStore() {
    _getMyAds();
  }

  @observable
  List<Ad> allAds = [];

  @computed
  List<Ad> get activeAds =>
      allAds.where((ad) => ad.status == AdStatus.ACTIVE).toList();
  List<Ad> get pendingAds =>
      allAds.where((ad) => ad.status == AdStatus.PENDING).toList();
  List<Ad> get soldAds =>
      allAds.where((ad) => ad.status == AdStatus.SOLD).toList();

  Future<void> _getMyAds() async {
    final user = GetIt.I<UserManagerStore>().userModel;

    try {
      loading = true;
      allAds = await AdRepository().getMyAds(user);
      loading = false;
      print(allAds);
    } catch (e, ex) {
      print('$e >>> $ex');
    }
  }

  @observable
  bool loading = false;

  void refresh() => _getMyAds();

  Future<void> soldAd(Ad ad) async {
    loading = true;
    await AdRepository().sold(ad);
    refresh();
  }

  Future<void> deleteAd(Ad ad) async {
    loading = true;
    await AdRepository().delete(ad);
    refresh();
  }
}
