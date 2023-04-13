part of 'bloc.dart';

abstract class Event extends Equatable {
  const Event();

  @override
  List<Object?> get props => [];
}

class GetPeopleEvent extends Event {}

class ReloadPeopleEvent extends Event {}

class GetMorePeopleEvent extends Event {}

class ClearMoviesCurrenEvent extends Event {}

class GetMoviesEvent extends Event {
  final PeopleModel peopleModel;
  const GetMoviesEvent(
    this.peopleModel,
  );
}

class SelectFilterEvent extends Event {
  final String filter;
  const SelectFilterEvent(this.filter);
}

class ChangeDegreesEvent extends Event {
  final CoordinateModel coordinateModel;
  final CoordinateModel degreeModel;
  const ChangeDegreesEvent(this.coordinateModel, this.degreeModel);
}
