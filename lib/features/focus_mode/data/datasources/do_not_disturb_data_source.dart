import 'package:do_not_disturb/do_not_disturb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'do_not_disturb_data_source.g.dart';

class DoNotDisturbDataSource {
  final DoNotDisturbPlugin _dndPlugin;

  DoNotDisturbDataSource(this._dndPlugin);

  Future<bool> get isDndEnabled async => await _dndPlugin.isDndEnabled();

  Future<bool> enableDNDMode() async {
    final hasPermission = await _checkNotificationPolicyAccessGranted();
    //await Future.delayed(const Duration(milliseconds: 50));

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

  Future<bool> disableDNDMode() async {
    final hasPermission = await _dndPlugin.isNotificationPolicyAccessGranted();

    if (!hasPermission) {
      final hasPermission = await _checkNotificationPolicyAccessGranted();
      //await Future.delayed(const Duration(milliseconds: 50));

      if (!hasPermission) {
        await _dndPlugin.openNotificationPolicyAccessSettings();
        return false;
      }
    }

    await _dndPlugin.setInterruptionFilter(InterruptionFilter.all);
    return true;
  }

  Future<bool> _checkNotificationPolicyAccessGranted() async {
    //try {
    final bool isNotificationPolicyAccessGranted = await _dndPlugin
        .isNotificationPolicyAccessGranted();

    return isNotificationPolicyAccessGranted;
    /*} catch (e) {
      throw DndNotificationPolicyAccessException();
    }*/
  }
}

@riverpod
DoNotDisturbDataSource doNotDisturbDataSource(Ref ref) {
  final dndPlugin = DoNotDisturbPlugin();
  return DoNotDisturbDataSource(dndPlugin);
}
