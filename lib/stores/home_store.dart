import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlomobx/models/ad.dart';
import 'package:xlomobx/models/category.dart';
import 'package:xlomobx/repositories/ad_repository.dart';
import 'package:xlomobx/stores/connectivity_store.dart';
import 'package:xlomobx/stores/filter_store.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  _HomeStore() {
    autorun((_) async {
      connectivityStore.connected;
      try {
        setLoading(true);
        final newAds = await AdRepository().getHomeAdList(
          filterStore: filterStore,
          search: search,
          category: category,
          page: page,
        );
        debugPrint("#111");
        debugPrint(newAds.toString());
        //adList.clear();
        addNewAds(newAds);
        //adList.addAll(newAds);
        setError(null);
        setLoading(false);
      } catch (e) {
        //setLoading(false);
        setError(e);
      }
    });
  }

  ObservableList<Ad> adList = ObservableList<Ad>();

  @observable
  String search = '';

  @action
  setSearch(String value) {
    search = value;
    resetPage();
  }

  @observable
  Category category;

  @action
  setCategory(Category value) {
    category = value;
    resetPage();
  }

  @observable
  FilterStore filterStore = FilterStore();

  FilterStore get clonedFilter => filterStore.clone();

  @action
  void setFilter(FilterStore value) {
    filterStore = value;
    resetPage();
  }

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  bool loading;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  int page = 0;

  @observable
  bool lastPage = false;

  @action
  void loadNextPage() {
    page++;
  }

  @action
  void addNewAds(List<Ad> newAds) {
    print('add new ${newAds.length}');
    if (newAds.length < 10) lastPage = true;
    adList.addAll(newAds);
  }

  @computed
  int get itemCount => lastPage ? adList.length : adList.length + 1;

  void resetPage() {
    page = 0;
    adList.clear();
    lastPage = false;
  }

  @computed
  bool get showProgress => loading && adList.isEmpty;
}
