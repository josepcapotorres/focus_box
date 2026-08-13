import 'dart:async';

import 'package:flutter/widgets.dart';

class TimerManager with WidgetsBindingObserver {
  DateTime? _startTime;
  Duration _accumulatedBeforeStart = Duration.zero;
  Timer? _ticker;

  // Callback para actualizar tu estado/UI
  final Function(Duration) onTick;

  TimerManager({required this.onTick}) {
    WidgetsBinding.instance.addObserver(this);
  }

  void startTimer(Duration currentTaskTime) {
    stopTimer();
    _accumulatedBeforeStart = currentTaskTime;
    _startTime = DateTime.now();

    onTick(currentTaskTime);

    _startTicker();
  }

  void _startTicker() {
    _ticker?.cancel();

    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      final totalElapsed = _updateDuration();
      onTick(totalElapsed);
    });
  }

  void stopTimer() {
    _ticker?.cancel();
    _ticker = null;
  }

  Duration _updateDuration() {
    if (_startTime == null) return Duration.zero;
    final elapsed = DateTime.now().difference(_startTime!);
    final totalElapsed = _accumulatedBeforeStart + elapsed;
    return totalElapsed;
  }

  // Detectar cuándo la app vuelve del segundo plano
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _startTime != null) {
      // Re-sincronizar el tiempo inmediatamente al volver
      final totalElapsed = _updateDuration();
      onTick(totalElapsed);
      _startTicker();
    }
  }

  /// By the time the timer gets stopped/paused, it returns the total elapsed time
  Duration pauseTimer() {
    _ticker?.cancel();

    final totalElapsed = _updateDuration();

    _startTime = null;

    return totalElapsed;
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker?.cancel();
  }
}
