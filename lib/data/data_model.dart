class CropProduction {
  final String crop;
  final double production;

  CropProduction({required this.crop, required this.production});

  factory CropProduction.fromJson(Map<String, dynamic> json) {
    return CropProduction(
      crop: json['crops'],
      production: double.parse(json['production__in_million_tonnes_']),
    );
  }
}
