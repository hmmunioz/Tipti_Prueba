part of 'bloc.dart';

abstract class State extends Equatable {
  const State(this.model);

  final Model model;

  @override
  List<Object?> get props => [model];
}

class InitialState extends State {
  const InitialState(Model model) : super(model);
}

class LoadingState extends State {
  const LoadingState(Model model) : super(model);
}

class LoadedState extends State {
  const LoadedState(Model model) : super(model);
}

class LoadingMoreState extends State {
  const LoadingMoreState(Model model) : super(model);
}

class ErrorState extends State {
  const ErrorState(Model model) : super(model);
}

class SelectFilterState extends State {
  const SelectFilterState(Model model) : super(model);
}

class ChangeDegreeState extends State {
  const ChangeDegreeState(Model model) : super(model);
}

class ChangeCoordinateState extends State {
  const ChangeCoordinateState(Model model) : super(model);
}

class GetMoviesState extends State {
  const GetMoviesState(Model model) : super(model);
}

class LoadingMoviesState extends State {
  const LoadingMoviesState(Model model) : super(model);
}

class LoadedMoviesState extends State {
  const LoadedMoviesState(Model model) : super(model);
}

class ShowLoaderState extends State {
  const ShowLoaderState(Model model) : super(model);
}

class Model extends Equatable {
  const Model({
    this.peopleList = const [],
    this.count = 0,
    this.next = "",
    this.previous = "",
    this.isLast = false,
    this.filter = "",
    this.degreeX = 0.0,
    this.degreeY = 0.0,
    this.degreeZ = 0.0,
    this.coordinatesString = "",
    this.coordinateModel = const CoordinateModel(x: 0, y: 0, z: 0),
    this.currentMovies = const [],
    this.currentPerson,
    this.previousPerson,
    this.showLoaderMovies = false,
    this.showListMovies = false,
  });

  final List<PeopleModel> peopleList;
  final int count;
  final String next;
  final String previous;
  final bool isLast;
  final String filter;
  final double degreeX;
  final double degreeY;
  final double degreeZ;
  final String coordinatesString;
  final CoordinateModel coordinateModel;
  final List<MovieModel> currentMovies;
  final PeopleModel? currentPerson;
  final PeopleModel? previousPerson;
  final bool showLoaderMovies;
  final bool showListMovies;
  Model copyWith({
    List<PeopleModel>? peopleList,
    int? count,
    String? next,
    String? previous,
    bool? isLast,
    String? filter,
    double? degreeX,
    double? degreeY,
    double? degreeZ,
    String? coordinatesString,
    CoordinateModel? coordinateModel,
    List<MovieModel>? currentMovies,
    PeopleModel? currentPerson,
    PeopleModel? previousPerson,
    bool? showLoaderMovies,
    bool? showListMovies,
  }) {
    return Model(
      peopleList: peopleList ?? this.peopleList,
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      isLast: isLast ?? this.isLast,
      filter: filter ?? this.filter,
      degreeX: degreeX ?? this.degreeX,
      degreeY: degreeY ?? this.degreeY,
      degreeZ: degreeZ ?? this.degreeZ,
      coordinatesString: coordinatesString ?? this.coordinatesString,
      coordinateModel: coordinateModel ?? this.coordinateModel,
      currentMovies: currentMovies ?? this.currentMovies,
      currentPerson: currentPerson ?? this.currentPerson,
      previousPerson: previousPerson ?? this.previousPerson,
      showLoaderMovies: showLoaderMovies ?? this.showLoaderMovies,
      showListMovies: showListMovies ?? this.showListMovies,
    );
  }

  @override
  List<Object?> get props => [
        peopleList,
        count,
        next,
        previous,
        isLast,
        filter,
        degreeX,
        degreeY,
        degreeZ,
        coordinatesString,
        coordinateModel,
        currentMovies,
        currentPerson,
        previousPerson,
        showLoaderMovies,
        showListMovies,
      ];
}
