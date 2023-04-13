import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tipti_test/app/_childrens/home/bloc/bloc.dart' as bloc;
import 'package:tipti_test/app/_childrens/home/enums/home/people_filter_enum.dart';
import 'package:tipti_test/app/_childrens/home/widgets/cube_gyroscope.dart';
import 'package:tipti_test/app/_childrens/home/widgets/list_view_infinite.dart';
import 'package:tipti_test/app/_childrens/home/widgets/filters_widget.dart';
import 'package:tipti_test/app/_childrens/home/widgets/no_result_widget.dart';
import 'package:tipti_test/app/_childrens/home/widgets/card_skeleton.dart';
import 'package:tipti_test/app/_childrens/home/widgets/card_people.dart';
import 'package:tipti_test/app/constants/assets.dart';
import 'package:tipti_test/app/constants/texts.dart';

import 'package:tipti_test/app/models/home_models/people_model.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc.Bloc()
        ..add(bloc.SelectFilterEvent(PeopleFilterEnum.all.value))
        ..add(bloc.GetPeopleEvent()),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black,
            onPressed: () {
              exit(0);
            }),
        title: Image.asset(
          AssetsUIValues.logoTipti,
          height: size.height * 0.08,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: size.height * .02),
            const Text(
              TextUIValues.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: size.height * .02),
            const CubeGyroscopeMain(),
            SizedBox(height: size.height * .05),
            const Text(
              TextUIValues.starWarscharacters,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: size.height * .02),
            const ApiFilters(
              peopleFilterEnumList: [
                PeopleFilterEnum.all,
                PeopleFilterEnum.female,
                PeopleFilterEnum.male,
                PeopleFilterEnum.unknown
              ],
            ),
            BlocBuilder<bloc.Bloc, bloc.State>(builder: (context, state) {
              List<PeopleModel> people = [];
              if (state.model.filter == PeopleFilterEnum.all.value ||
                  state.model.filter == "") {
                people = state.model.peopleList.toSet().toList();
              }
              if (state.model.filter == PeopleFilterEnum.male.value) {
                people = state.model.peopleList
                    .where((element) =>
                        element.gender ==
                        PeopleFilterEnum.male.value.toLowerCase())
                    .toSet()
                    .toList();
              }
              if (state.model.filter == PeopleFilterEnum.female.value) {
                people = state.model.peopleList
                    .where((element) =>
                        element.gender ==
                        PeopleFilterEnum.female.value.toLowerCase())
                    .toSet()
                    .toList();
              }

              if (state.model.filter == PeopleFilterEnum.unknown.value) {
                people = state.model.peopleList
                    .where((element) =>
                        element.gender == PeopleFilterEnum.unknown.key)
                    .toSet()
                    .toList();
              }
              if (people.isEmpty && state is bloc.LoadedState) {
                return Center(
                  child: NoResultWidget(
                    title: TextUIValues.resultNoFound,
                    onTap: () {
                      context.read<bloc.Bloc>().add(bloc.GetMorePeopleEvent());
                    },
                  ),
                );
              } else if (state is bloc.ErrorState) {
                return Center(
                  child: NoResultWidget(
                    title: TextUIValues.tryAgain,
                    onTap: () {
                      context.read<bloc.Bloc>().add(bloc.GetMorePeopleEvent());
                    },
                  ),
                );
              } else if (state is bloc.InitialState ||
                  state is bloc.LoadingState) {
                return const _CardSkeletonList();
              } else {
                return SizedBox(
                  height: size.height * .50,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<bloc.Bloc>().add(bloc.ReloadPeopleEvent());
                    },
                    child: ListViewInfinite(
                      onLoadingMore: () {
                        context
                            .read<bloc.Bloc>()
                            .add(bloc.GetMorePeopleEvent());
                      },
                      isLastPage: state.model.isLast,
                      loadingWidget: Padding(
                        padding: const EdgeInsets.only(
                          left: 17,
                          right: 17,
                          bottom: 25,
                        ),
                        child: Column(
                          children: const [
                            CardSkeleton(),
                          ],
                        ),
                      ),
                      children: List.generate(
                        people.length,
                        (index) {
                          final person = people[index];

                          return CardPeople(
                            person: person,
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
            }),
            BlocBuilder<bloc.Bloc, bloc.State>(builder: (context, state) {
              return Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "${TextUIValues.page}: ${state.model.previous != "" ? state.model.previous.split("page=")[1] : "1"}",
                      textAlign: TextAlign.right,
                    ),
                  ));
            })
          ],
        ),
      ),
    );
  }
}

class _CardSkeletonList extends StatelessWidget {
  const _CardSkeletonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.separated(
        itemCount: 10,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 16,
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 15.0),
        itemBuilder: (_, __) => const CardSkeleton(),
      );
}
