class ScoreModifyModel {
  ScoreModifyModel({
    required this.category,
    required this.value,
  });

  late final String category;
  late final List<int> value;

  ScoreModifyModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    value = List<int>.from(json['value']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category'] = category;
    _data['value'] = value;
    return _data;
  }
}
