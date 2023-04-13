import 'package:equatable/equatable.dart';
import 'package:tipti_test/app/models/home_models/people_model.dart';

class ResultPeopletModel extends Equatable {
  final int count;
  final String next;
  final String previous;
  final List<PeopleModel> results;
  final bool isLast;

  const ResultPeopletModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
    required this.isLast,
  });

  ResultPeopletModel copyWith({
    int? count,
    String? next,
    String? previous,
    List<PeopleModel>? results,
    bool? isLast,
  }) {
    return ResultPeopletModel(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
        isLast: isLast ?? this.isLast);
  }

  factory ResultPeopletModel.fromJson(Map<String, dynamic> json) {
    final resultList = List<PeopleModel>.from(
        json["results"].map((x) => PeopleModel.fromJson(x)));
    return ResultPeopletModel(
        count: json['count'] ?? "",
        next: json['next'] ?? "",
        previous: json['previous'] ?? "",
        results: resultList,
        isLast: resultList.isEmpty ? true : false);
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results,
      'isLast': isLast,
    };
  }

  @override
  List<Object?> get props => [
        count,
        next,
        previous,
        results,
        isLast,
      ];
}
