abstract class DoNotDisturbDataSource {
  Future<bool> get isDndEnabled;

  Future<bool> enableDNDMode();

  Future<bool> disableDNDMode();
}
