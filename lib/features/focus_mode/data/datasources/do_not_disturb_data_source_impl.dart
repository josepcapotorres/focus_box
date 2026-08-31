import 'package:do_not_disturb/do_not_disturb.dart';
import 'package:focus_box/features/focus_mode/data/datasources/do_not_disturb_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'do_not_disturb_data_source_impl.g.dart';

class DoNotDisturbDataSourceImpl extends DoNotDisturbDataSource {
  final DoNotDisturbPlugin _dndPlugin;

  DoNotDisturbDataSourceImpl(this._dndPlugin);

  @override
  Future<bool> get isDndEnabled async => await _dndPlugin.isDndEnabled();

  @override
  Future<bool> enableDNDMode() async {
    final hasPermission = await _checkNotificationPolicyAccessGranted();

    if (!hasPermission) {
      await _dndPlugin.openNotificationPolicyAccessSettings();
      return false;
    }

    final isDndEnabled = await _dndPlugin.isDndEnabled();

    if (isDndEnabled) {
      await _dndPlugin.setInterruptionFilter(InterruptionFilter.priority);
      return true;
    } else {
      await _dndPlugin.openDndSettings();
      return false;
    }
  }

  @override
  Future<bool> disableDNDMode() async {
    bool hasPermission = await _dndPlugin.isNotificationPolicyAccessGranted();

    if (!hasPermission) {
      hasPermission = await _checkNotificationPolicyAccessGranted();

      if (!hasPermission) {
        await _dndPlugin.openNotificationPolicyAccessSettings();
        return false;
      }
    }

    await _dndPlugin.setInterruptionFilter(InterruptionFilter.all);
    return true;
  }

  Future<bool> _checkNotificationPolicyAccessGranted() async {
    final bool isNotificationPolicyAccessGranted = await _dndPlugin
        .isNotificationPolicyAccessGranted();

    return isNotificationPolicyAccessGranted;
  }
}

@riverpod
DoNotDisturbDataSource doNotDisturbDataSource(Ref ref) {
  final dndPlugin = DoNotDisturbPlugin();
  return DoNotDisturbDataSourceImpl(dndPlugin);
}
