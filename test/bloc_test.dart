import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tipti_test/app/_childrens/home/bloc/bloc.dart';
import 'package:tipti_test/app/_childrens/home/repository.dart';
import 'package:tipti_test/app/models/home_models/coordinate_model.dart';
import 'package:tipti_test/app/models/home_models/movie_model.dart';
import 'package:tipti_test/app/models/home_models/people_model.dart';
import 'package:tipti_test/app/models/result_models/result_people_model.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockRepository = MockRepository();
  const String basePeopleUrl = 'https://swapi.dev/api/people';
  const String baseMoviesUrl = 'https://swapi.dev/api/films/1/';
  const String fakeUrl = 'https://fakeurlprueba';
  const model = Model();

  late Bloc bloc;
  ResultPeopletModel? resultPeopletModel;
  PeopleModel currentPerson = const PeopleModel(
    name: "Hola",
    height: "",
    mass: "",
    hairColor: "",
    skinColor: "",
    eyeColor: "",
    birthYear: "",
    gender: "male",
    homeworld: "",
    films: [baseMoviesUrl],
    species: [],
    vehicles: [],
    starships: [],
    created: "",
    edited: "",
    url: "",
  );

  MovieModel movieModel = MovieModel(
    title: "",
    episodeId: "",
    openingCrawl: "",
    director: "",
    producer: "",
    personName: currentPerson.name,
    releaseDate: "",
  );
  CoordinateModel coordinateModel = const CoordinateModel(x: 0, y: 0, z: 0);
  CoordinateModel degreeModel = const CoordinateModel(x: 0, y: 0, z: 0);
  setUpAll(() => bloc = Bloc(repository: mockRepository));

  test('emits [InitialState]', () {
    expect(
      bloc.state,
      const InitialState(model),
    );
  });
  group('people_bloc', () {
    blocTest<Bloc, State>(
      'GetPeopleEvent [LoadedState]',
      build: () {
        when(
          () => mockRepository.getPeopleApi(),
        ).thenAnswer((_) async => resultPeopletModel);
        return bloc;
      },
      act: (bloc) => bloc.add(GetPeopleEvent()),
      expect: () => [
        const LoadingState(model),
        LoadedState(model.copyWith(isLast: true)),
      ],
    );

    blocTest<Bloc, State>(
      'GetPeopleEvent [ErrorState]',
      build: () {
        when(
          () => mockRepository.getPeopleApi(uri: basePeopleUrl),
        ).thenAnswer((_) async => resultPeopletModel);
        return bloc;
      },
      act: (bloc) => bloc.add(GetPeopleEvent()),
      expect: () => [
        const LoadingState(model),
        const ErrorState(model),
      ],
    );

    blocTest<Bloc, State>(
      'GetMoviesEvent [GetMoviesState]',
      build: () {
        when(
          () => mockRepository.getMovies(uri: currentPerson.films[0]),
        ).thenAnswer((_) async => movieModel);
        return bloc;
      },
      act: (bloc) => bloc.add(GetMoviesEvent(currentPerson)),
      expect: () => [
        LoadingMoviesState(
            model.copyWith(showListMovies: false, showLoaderMovies: true)),
        LoadedMoviesState(model.copyWith(
          currentMovies: [
            movieModel,
          ],
          showListMovies: false,
          previous: null,
          showLoaderMovies: true,
          currentPerson: currentPerson,
        )),
        GetMoviesState(model.copyWith(
          currentMovies: [movieModel],
          showLoaderMovies: false,
          currentPerson: currentPerson,
          showListMovies: true,
        )),
      ],
    );

    blocTest<Bloc, State>(
      'GetMoviesEvent [ErrorState]',
      build: () {
        when(
          () => mockRepository.getMovies(uri: fakeUrl),
        ).thenAnswer((_) async => null);
        return bloc;
      },
      act: (bloc) => bloc.add(GetMoviesEvent(currentPerson)),
      expect: () => [
        LoadingMoviesState(
            model.copyWith(showListMovies: false, showLoaderMovies: true)),
        LoadedMoviesState(model.copyWith(
          showListMovies: false,
          previous: null,
          showLoaderMovies: true,
        )),
        ErrorState(model.copyWith(
          showLoaderMovies: true,
          showListMovies: false,
        )),
      ],
    );

    blocTest<Bloc, State>(
      'ReloadPeopleEvent [LoadedState]',
      build: () {
        when(
          () => mockRepository.getPeopleApi(uri: ''),
        ).thenAnswer((_) async => resultPeopletModel);
        return bloc;
      },
      act: (bloc) => bloc.add(ReloadPeopleEvent()),
      expect: () => [
        const LoadingState(model),
        LoadedState(model.copyWith(isLast: true)),
      ],
    );

    blocTest<Bloc, State>(
      'ReloadPeopleEvent [ErrorState]',
      build: () {
        when(
          () => mockRepository.getPeopleApi(uri: fakeUrl),
        ).thenAnswer((_) async => resultPeopletModel);
        return bloc;
      },
      act: (bloc) => bloc.add(ReloadPeopleEvent()),
      expect: () => [
        const LoadingState(model),
        const ErrorState(model),
      ],
    );

    blocTest<Bloc, State>(
      'GetMorePeopleEvent [LoadedState]',
      build: () {
        when(
          () => mockRepository.getPeopleApi(uri: ''),
        ).thenAnswer((_) async => resultPeopletModel);
        return bloc;
      },
      act: (bloc) => bloc.add(GetMorePeopleEvent()),
      expect: () => [
        const LoadingMoreState(model),
        LoadedState(model.copyWith(isLast: true)),
      ],
    );

    blocTest<Bloc, State>(
      'GetMorePeopleEvent [ErrorState]',
      build: () {
        when(
          () => mockRepository.getPeopleApi(uri: fakeUrl),
        ).thenAnswer((_) async => resultPeopletModel);
        return bloc;
      },
      act: (bloc) => bloc.add(GetMorePeopleEvent()),
      expect: () => [
        const LoadingMoreState(model),
        const ErrorState(model),
      ],
    );

    blocTest<Bloc, State>(
      'SelectFilterEvent [LoadedState]',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(const SelectFilterEvent("")),
      expect: () => [
        const LoadedState(model),
        const SelectFilterState(model),
        const LoadedState(model),
      ],
    );

    blocTest<Bloc, State>(
      'ChangeDegreesEvent [ChangeDegreeState]',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(ChangeDegreesEvent(coordinateModel, degreeModel)),
      expect: () => [
        const ChangeDegreeState(model),
      ],
    );
  });
}
