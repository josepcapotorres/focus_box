import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../managers/timer_manager.dart';

part 'ticker_provider.g.dart';

@Riverpod(keepAlive: true)
class Ticker extends _$Ticker {
  TimerManager? _manager;

  @override
  Duration build() {
    _manager = TimerManager(
      onTick: (duration) {
        state = duration;
      },
    );

    ref.onDispose(() {
      _manager?.dispose();
    });

    return Duration.zero;
  }

  void startTimer(Duration timeAlreadyDone) {
    _manager?.startTimer(timeAlreadyDone);
  }

  void resumeTimer() {
    final initialTime = state;

    _manager?.startTimer(initialTime);
  }

  Duration pauseTimer() {
    return _manager?.pauseTimer() ?? state;
  }
}
