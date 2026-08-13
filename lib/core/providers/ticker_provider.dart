import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../timer_manager.dart';

part 'ticker_provider.g.dart';

@Riverpod(keepAlive: true)
class Ticker extends _$Ticker {
  TimerManager? _manager;

  @override
  Duration build() {
    _manager = TimerManager(
      onTick: (duration) {
        state = duration;
        print(
          'TTTTT TICKER STATE UPDATE: $duration '
          '${DateTime.now().toIso8601String()}',
        );
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
    // TODO: Store it in the local db
    return _manager?.pauseTimer() ?? state;
  }
}
