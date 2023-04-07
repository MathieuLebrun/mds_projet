class ScoreResponseModel {
  final String id;
  final String category;
  final List<int> value;

  ScoreResponseModel({
    required this.id,
    required this.category,
    required this.value,
  });

  factory ScoreResponseModel.fromJson(Map<String, dynamic> json) {
    return ScoreResponseModel(
      id: json['_id'],
      category: json['category'],
      value: List<int>.from(json['value']),
    );
  }
}
