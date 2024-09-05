import 'package:flutter_application_1/data/data_model.dart';
import 'package:flutter_application_1/domain/provider_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final cropProductionProvider =
    FutureProvider<List<CropProduction>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchCropProduction();
});

final selectedCropProvider = StateProvider<String?>((ref) => null);
