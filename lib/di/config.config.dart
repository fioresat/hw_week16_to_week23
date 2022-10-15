// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/orders_repository.dart' as _i3;
import '../domain/interactor/orders_interactor.dart' as _i4;
import '../ui/orders_store.dart' as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.OrdersRepository>(() => _i3.OrdersRepository());
  gh.factory<_i4.OrdersInteractor>(
      () => _i4.OrdersInteractor(get<_i3.OrdersRepository>()));
  gh.factory<_i5.OrdersStore>(
      () => _i5.OrdersStore(get<_i4.OrdersInteractor>()));
  return get;
}
