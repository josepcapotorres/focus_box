extension DurationFormattingExtension on Duration {
  /// Round duration to the nearest second to avoid jumps by milliseconds
  Duration get _roundedToSeconds {
    final microseconds = inMicroseconds;
    final roundedSeconds = (microseconds / 1000000).round();
    return Duration(seconds: roundedSeconds);
  }

  String toHoursMinutesSeconds() {
    final rounded = _roundedToSeconds;
    final hours = rounded.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = rounded.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = rounded.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }

  double progressOutOfTen(Duration totalDuration) {
    if (this >= totalDuration) return 100;

    return (inMilliseconds * 100 / totalDuration.inMilliseconds);
  }

  String toDisplayHoursMinutes() {
    final totalMinutes = inMinutes;

    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}';
  }

  String timeLineStepText() {
    final hours = inHours.remainder(24);
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    String text = "";

    if (hours > 0) {
      text += "$hours h ";
    }

    if (minutes > 0) {
      text += "$minutes min ";
    }

    text += "$seconds s";

    return text;
  }
}
