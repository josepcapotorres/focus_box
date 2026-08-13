import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/do_not_disturb_data_source.dart';

part 'do_not_disturb_repository.g.dart';

class DoNotDisturbRepository {
  final DoNotDisturbDataSource _dataSource;

  const DoNotDisturbRepository(this._dataSource);

  Future<bool> get isDndEnabled async => await _dataSource.isDndEnabled;

  Future<bool> enableDNDMode() => _dataSource.enableDNDMode();

  Future<bool> disableDNDMode() => _dataSource.disableDNDMode();
}

@riverpod
DoNotDisturbRepository doNotDisturbRepository(Ref ref) {
  final dataSource = ref.watch(doNotDisturbDataSourceProvider);
  return DoNotDisturbRepository(dataSource);
}
