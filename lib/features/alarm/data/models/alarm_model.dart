class AlarmModel {
  final int? id;
  final DateTime dateTime;
  final bool isActive;

  AlarmModel({
    this.id,
    required this.dateTime,
    this.isActive = true,
  });
//obj to json map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'isActive': isActive ? 1 : 0,
    };
  }
//json map to obj
  factory AlarmModel.fromMap(Map<String, dynamic> map) {
    return AlarmModel(
      id: map['id'],
      dateTime: DateTime.parse(map['dateTime']),
      isActive: map['isActive'] == 1,
    );
  }
//for copy object
  AlarmModel copyWith({int? id, DateTime? dateTime, bool? isActive}) {
    return AlarmModel(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      isActive: isActive ?? this.isActive,
    );
  }
}