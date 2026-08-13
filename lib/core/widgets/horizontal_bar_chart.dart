import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/focus_mode/presentation/providers/focus_session_provider.dart';
import '../../features/home/presentation/providers/home_tasks_provider.dart';
import '../extensions/duration_formatting_extension.dart';
import '../providers/ticker_provider.dart';

class HorizontalBarChart extends ConsumerWidget {
  final String taskId;
  final double totalValue;
  final Color backgroundColor;
  final Color foregroundColor;

  const HorizontalBarChart({
    super.key,
    required this.taskId,
    required this.totalValue,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(currentTaskProvider(taskId));
    final elapsed = ref.watch(tickerProvider);
    final currentTaskId = ref.watch(
      focusSessionProvider.select((s) => s?.taskId),
    );
    final isCurrentTask = currentTaskId == task?.id;
    final workedTime = isCurrentTask
        ? elapsed
        : task?.timeAlreadyDone ?? Duration.zero;

    final timeTotal = task?.timeTotal ?? Duration.zero;

    final currentValue = workedTime.progressOutOfTen(timeTotal);

    return SizedBox(
      height: 4,
      width: double.infinity,
      child: RotatedBox(
        quarterTurns: 1,
        child: BarChart(
          BarChartData(
            maxY: totalValue,
            alignment: BarChartAlignment.center,
            barTouchData: const BarTouchData(enabled: false),
            // Desactivamos cuadrícula y bordes innecesarios
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: const FlTitlesData(show: false),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: totalValue,
                    borderRadius: BorderRadius.circular(8),
                    rodStackItems: [
                      // Tramo 1: Progreso actual
                      BarChartRodStackItem(0, currentValue, foregroundColor),
                      // Tramo 2: Fondo / Restante hasta el total
                      BarChartRodStackItem(
                        currentValue,
                        totalValue,
                        backgroundColor,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
