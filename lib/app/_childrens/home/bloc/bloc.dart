import 'package:bloc/bloc.dart' as bloc;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tipti_test/app/_childrens/home/repository.dart';
import 'package:tipti_test/app/models/home_models/movie_model.dart';
import 'package:tipti_test/app/models/home_models/people_model.dart';
import 'package:tipti_test/app/models/home_models/coordinate_model.dart';
part 'event.dart';
part 'state.dart';

class Bloc extends bloc.Bloc<Event, State> {
  Bloc({Repository? repository})
      : repository = repository ??= Repository(),
        super(const InitialState(Model())) {
    on<GetPeopleEvent>(_onGetPeopleEvent);
    on<GetMoviesEvent>(_onGetMoviesEvent);
    on<ReloadPeopleEvent>(_onReloadPeopleEvent);
    on<GetMorePeopleEvent>(_onGetMorePeopleEvent);
    on<SelectFilterEvent>(_onSelectFilterEvent);
    on<ChangeDegreesEvent>(_onChangeDegreesEvent);
  }

  late Repository repository;

  Future<Model> _getPeople(String filter, [bool isReload = false]) async {
    final oldPeople = state.model.peopleList;
    List<PeopleModel> peopleList = [];
    if (!state.model.isLast) {
      final response = await repository.getPeopleApi(
        uri: isReload ? "" : state.model.next,
      );

      peopleList = [...oldPeople, ...response?.results ?? []];

      return state.model.copyWith(
          peopleList: peopleList,
          filter: state.model.filter,
          previous: response?.previous,
          next: response?.next,
          count: response?.count,
          isLast:
              response?.next != null && response?.next != "" ? false : true);
    }
    return state.model;
  }

  Future<Model> _getMoviesByPerson(PeopleModel peopleModel) async {
    List<MovieModel> newMovieList = [];

    await Future.wait(peopleModel.films.map((uriMovie) async {
      final movie = await repository.getMovies(uri: uriMovie);
      if (movie != null) {
        newMovieList.add(movie.copyWith(
          personName: peopleModel.name,
        ));
      }
    }));
    final movieList = [...state.model.currentMovies, ...newMovieList];
    return state.model.copyWith(
      currentMovies: movieList.toSet().toList(),
      showLoaderMovies: true,
      currentPerson: peopleModel,
    );
  }

  void _onGetPeopleEvent(
    GetPeopleEvent event,
    Emitter<State> emit,
  ) async {
    emit(LoadingState(state.model));
    try {
      final model = await _getPeople(state.model.filter);
      emit(LoadedState(model));
    } catch (error) {
      emit(ErrorState(state.model));
    }
  }

  void _onGetMorePeopleEvent(
    GetMorePeopleEvent event,
    Emitter<State> emit,
  ) async {
    emit(LoadingMoreState(state.model));
    try {
      final model = await _getPeople(state.model.filter);
      emit(LoadedState(model));
    } catch (error) {
      emit(ErrorState(state.model));
    }
  }

  void _onReloadPeopleEvent(
    ReloadPeopleEvent event,
    Emitter<State> emit,
  ) async {
    emit(LoadingState(state.model.copyWith(
      isLast: false,
      peopleList: [],
    )));
    try {
      final model = await _getPeople(
        state.model.filter,
        true,
      );

      emit(LoadedState(model));
    } catch (error) {
      emit(ErrorState(state.model));
    }
  }

  void _onSelectFilterEvent(
    SelectFilterEvent event,
    Emitter<State> emit,
  ) async {
    final peopleListTemporal = state.model.peopleList;
    emit(LoadedState(
      state.model.copyWith(
        peopleList: [],
      ),
    ));
    emit(
      SelectFilterState(
        state.model.copyWith(
          filter: event.filter,
          peopleList: peopleListTemporal,
        ),
      ),
    );
    emit(LoadedState(state.model));
  }

  void _onChangeDegreesEvent(
    ChangeDegreesEvent event,
    Emitter<State> emit,
  ) async {
    emit(
      ChangeDegreeState(
        state.model.copyWith(
          degreeX: (state.model.degreeX) + (event.coordinateModel.x),
          degreeY: (state.model.degreeY) + (event.coordinateModel.y),
          degreeZ: (state.model.degreeZ) + (event.coordinateModel.z),
          coordinateModel: event.coordinateModel,
          showLoaderMovies: false,
        ),
      ),
    );
  }

  void _onGetMoviesEvent(
    GetMoviesEvent event,
    Emitter<State> emit,
  ) async {
    emit(LoadingMoviesState(
      state.model.copyWith(
        showLoaderMovies: true,
        previousPerson: state.model.currentPerson,
      ),
    ));

    try {
      if (state.model.currentMovies
              .where((cm) => cm.personName == event.peopleModel.name)
              .toList()
              .isEmpty &&
          state.model.previousPerson?.name != event.peopleModel.name) {
        final model = await _getMoviesByPerson(event.peopleModel);
        emit(
          LoadedMoviesState(model),
        );
        emit(
          GetMoviesState(model.copyWith(
            showListMovies: true,
            showLoaderMovies: false,
          )),
        );
      } else {
        if (state.model.previousPerson?.name == event.peopleModel.name) {
          emit(GetMoviesState(state.model.copyWith(
            currentPerson: event.peopleModel,
            showLoaderMovies: false,
            showListMovies: !state.model.showListMovies,
          )));
        } else {
          emit(GetMoviesState(state.model.copyWith(
            currentPerson: event.peopleModel,
            showLoaderMovies: false,
            showListMovies: true,
          )));
        }
      }
    } catch (error) {
      emit(
        LoadedMoviesState(state.model),
      );
      emit(ErrorState(state.model));
    }
  }
}
