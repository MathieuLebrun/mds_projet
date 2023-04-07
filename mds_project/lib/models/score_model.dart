class ScoreModel {
  final String id;
  final String category;
  final List<int> value;

  ScoreModel({
    required this.id,
    required this.category,
    required this.value,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) {
    return ScoreModel(
      id: json['_id'],
      category: json['category'],
      value: List<int>.from(json['value']),
    );
  }
}
