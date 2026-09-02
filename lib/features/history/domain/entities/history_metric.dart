import 'package:equatable/equatable.dart';

class HistoryMetric extends Equatable {
  final Duration realTimeDevoted;
  final Duration expectedTime;
  final int focusRatioPercentage;

  const HistoryMetric(
    this.realTimeDevoted,
    this.expectedTime,
    this.focusRatioPercentage,
  );

  @override
  List<Object?> get props => [
    realTimeDevoted,
    expectedTime,
    focusRatioPercentage,
  ];
}
