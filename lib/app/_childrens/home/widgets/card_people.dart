import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tipti_test/app/_childrens/home/enums/home/people_filter_enum.dart';
import 'package:tipti_test/app/common_widgets/btn_widget.dart';
import 'package:tipti_test/app/constants/assets.dart';
import 'package:tipti_test/app/constants/texts.dart';
import 'package:tipti_test/app/models/home_models/people_model.dart';
import 'package:tipti_test/app/_childrens/home/bloc/bloc.dart' as bloc;

class CardPeople extends StatelessWidget {
  const CardPeople({Key? key, required this.person}) : super(key: key);
  final PeopleModel person;
  @override
  Widget build(BuildContext context) {
    return BlocListener<bloc.Bloc, bloc.State>(
      listener: listener,
      child: BlocBuilder<bloc.Bloc, bloc.State>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 17,
            ),
            child: Card(
              elevation: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: ListTile(
                      leading: Icon(
                        person.gender ==
                                PeopleFilterEnum.female.value.toLowerCase()
                            ? Icons.female_rounded
                            : person.gender ==
                                    PeopleFilterEnum.male.value.toLowerCase()
                                ? Icons.male_rounded
                                : Icons.help,
                        color: person.gender ==
                                PeopleFilterEnum.female.value.toLowerCase()
                            ? Colors.blueAccent
                            : person.gender ==
                                    PeopleFilterEnum.male.value.toLowerCase()
                                ? Colors.pinkAccent
                                : Colors.orangeAccent,
                        size: 30,
                      ),
                      isThreeLine: true,
                      title: Text(
                        " ${person.name}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " ${person.gender}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.height,
                                color: Colors.grey,
                              ),
                              Text(
                                person.height == "unknown"
                                    ? ' ${TextUIValues.height}: N/A'
                                    : ' ${TextUIValues.height}:  ${person.height} cm',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            const Icon(
                              Icons.movie,
                              color: Colors.grey,
                            ),
                            Text(
                              " ${TextUIValues.movies}:  ${person.films.length}",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ]),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      trailing: ButttonCustom(
                        onTap: () {
                          if (state.model.currentMovies
                                  .where((cm) => cm.personName == person.name)
                                  .toList()
                                  .isEmpty &&
                              state.model.previousPerson?.name != person.name) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                content: SizedBox(
                                  child: Image.asset(
                                    AssetsUIValues.staringLoading,
                                  ),
                                ),
                              ),
                            );
                          }
                          context.read<bloc.Bloc>().add(
                                bloc.GetMoviesEvent(person),
                              );
                        },
                        label: TextUIValues.movies,
                        fontSize: 11,
                        height: 20,
                        color: person.name == state.model.currentPerson?.name &&
                                state.model.showListMovies
                            ? Colors.orange
                            : Colors.orangeAccent,
                      ),
                    ),
                  ),
                  if (person.name == state.model.currentPerson?.name &&
                      state.model.showListMovies) ...[
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.model.currentMovies
                          .where((cm) => cm.personName == person.name)
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        final movie = state.model.currentMovies
                            .where((cm) => cm.personName == person.name)
                            .toList()[index];
                        return Card(
                          elevation: 0,
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_right),
                              Text("${movie.title} - ${movie.releaseDate}"),
                            ],
                          ),
                        );
                      },
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void listener(BuildContext context, bloc.State state) {
    if (state is bloc.LoadedMoviesState &&
        person.name == state.model.currentPerson?.name) {
      myCallback(() {
        Navigator.pop(context, true);
      });
    }
  }

  void myCallback(Function callback) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      callback();
    });
  }
}
