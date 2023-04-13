import 'package:equatable/equatable.dart';

class CoordinateModel extends Equatable {
  final double x;
  final double y;
  final double z;

  const CoordinateModel({
    required this.x,
    required this.y,
    required this.z,
  });

  CoordinateModel copyWith({
    double? x,
    double? y,
    double? z,
  }) {
    return CoordinateModel(
      x: x ?? this.x,
      y: y ?? this.y,
      z: z ?? this.z,
    );
  }

  factory CoordinateModel.fromJson(Map<String, dynamic> json) {
    return CoordinateModel(
      x: json['x'] is int ? double.parse(json['x'].toString()) : json['x'],
      y: json['y'] is int ? double.parse(json['y'].toString()) : json['y'],
      z: json['z'] is int ? double.parse(json['z'].toString()) : json['z'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'z': z,
    };
  }

  @override
  List<Object?> get props => [
        x,
        y,
        z,
      ];
}
