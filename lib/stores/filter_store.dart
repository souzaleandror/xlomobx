import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlomobx/stores/home_store.dart';

part 'filter_store.g.dart';

enum OrderBy { DATE, PRICE }

const VENDOR_TYPE_PARTICULAR = 1 << 0;
const VENDOR_TYPE_PROFESSIONAL = 1 << 1;
//const VENDOR_TYPE_STORE = 1 << 2;

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  _FilterStore({
    this.orderBy = OrderBy.PRICE,
    this.minPrice = 1,
    this.maxPrice = 100000,
    this.vendorType = VENDOR_TYPE_PARTICULAR,
  });

  @observable
  OrderBy orderBy;

  @action
  void setOrderBy(OrderBy value) => orderBy = value;

  @observable
  int minPrice;

  @observable
  int maxPrice;

  @action
  void setMinPrice(int value) => minPrice = value;

  @action
  void setMaxPrice(int value) => maxPrice = value;

  @computed
  String get priceError =>
      maxPrice != null && minPrice != null && maxPrice < minPrice
          ? 'Faixa de preco Invalido'
          : null;

  @observable
  int vendorType;

  @action
  void selectVendorType(int value) => vendorType = value;
  void setVendorType(int type) => vendorType = vendorType | type;
  void resetVendorType(int type) => vendorType = vendorType & ~type;

  @computed
  bool get isTypeParticular => (vendorType & VENDOR_TYPE_PARTICULAR) != 0;
  bool get isTypeProfessional => (vendorType & VENDOR_TYPE_PROFESSIONAL) != 0;

  @computed
  bool get isFormValid => priceError == null;

  void save() {
    GetIt.I<HomeStore>().setFilter(this);
  }

  FilterStore clone() {
    return FilterStore(
      orderBy: orderBy,
      minPrice: minPrice,
      maxPrice: maxPrice,
      vendorType: vendorType,
    );
  }
}
