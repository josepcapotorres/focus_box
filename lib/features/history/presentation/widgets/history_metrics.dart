import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/history_metrics_provider.dart';
import 'history_metric_card.dart';

class HistoryMetrics extends ConsumerWidget {
  const HistoryMetrics({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyMetricsAsync = ref.watch(historyMetricsProvider);

    final colorScheme = Theme.of(context).colorScheme;

    return historyMetricsAsync.when(
      data: (metrics) {
        final strRealTimeDevoted =
            "${metrics.realTimeDevoted.inHours.remainder(24)}h ${metrics.realTimeDevoted.inMinutes.remainder(60)}m";

        final strExpectedTime =
            "${metrics.expectedTime.inHours.remainder(24)}h ${metrics.expectedTime.inMinutes.remainder(60)}m";

        return Row(
          spacing: 16,
          children: [
            Expanded(
              child: HistoryMetricCard(
                label: "Tiempo real dedicado",
                metricValue: strRealTimeDevoted,
                backgroundColor: colorScheme.primaryContainer,
                labelColor: colorScheme.primary,
                metricColor: colorScheme.onSurface,
              ),
            ),
            Expanded(
              child: HistoryMetricCard(
                label: "Tiempo planificado",
                metricValue: strExpectedTime,
                backgroundColor: colorScheme.primaryContainer,
                labelColor: colorScheme.primary,
                metricColor: colorScheme.onSurface,
              ),
            ),
            Expanded(
              child: HistoryMetricCard(
                label: "Ratio de enfoque",
                metricValue: "${metrics.focusRatioPercentage}%",
                backgroundColor: colorScheme.secondaryContainer,
                labelColor: colorScheme.onSecondaryContainer,
                metricColor: colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        );
      },
      error: (_, _) =>
          const Center(child: Text("Error al obtener las métricas")),
      loading: () => const Align(
        alignment: .center,
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
