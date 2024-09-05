import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CropProductionChart extends ConsumerWidget {
  const CropProductionChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cropDataAsync = ref.watch(cropProductionProvider);
    final selectedCrop = ref.watch(selectedCropProvider);

    return cropDataAsync.when(
      data: (data) {
        final spots = data
            .map((e) => FlSpot(data.indexOf(e).toDouble(), e.production))
            .toList();

        return LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                dotData: const FlDotData(show: true),
                belowBarData: BarAreaData(show: false),
                color: selectedCrop != null
                    ? Colors.red // Highlight selected crop
                    : Colors.blue,
                aboveBarData: BarAreaData(show: false),
              ),
            ],
            lineTouchData: const LineTouchData(
              touchTooltipData: LineTouchTooltipData(),
              handleBuiltInTouches: true,
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
