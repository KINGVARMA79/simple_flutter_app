import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/chart_widget.dart';
import 'package:flutter_application_1/provider/data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CropProductionPage extends ConsumerWidget {
  const CropProductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cropDataAsync = ref.watch(cropProductionProvider);
    final selectedCrop = ref.watch(selectedCropProvider);

    return cropDataAsync.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(title: Text('Crop Production Chart')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DropdownButton<String>(
                  value: selectedCrop,
                  items: data.map((crop) {
                    return DropdownMenuItem<String>(
                      value: crop.crop,
                      child: Text(crop.crop),
                    );
                  }).toList(),
                  onChanged: (value) {
                    ref.read(selectedCropProvider.notifier).state = value;
                  },
                ),
                SizedBox(height: 16),
                Expanded(
                  child: CropProductionChart(),
                ),
                SizedBox(height: 16),
                if (selectedCrop != null) ...[
                  Text(
                    'Selected Crop: $selectedCrop',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Production: ${data.firstWhere((crop) => crop.crop == selectedCrop).production} Million Tonnes',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ],
            ),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
