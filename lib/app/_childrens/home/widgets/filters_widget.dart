import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tipti_test/app/_childrens/home/enums/home/people_filter_enum.dart';
import 'package:tipti_test/app/_childrens/home/bloc/bloc.dart' as bloc;
import 'package:flutter/material.dart';

class ApiFilters extends StatelessWidget {
  const ApiFilters({
    Key? key,
    required this.peopleFilterEnumList,
  }) : super(key: key);
  final List<PeopleFilterEnum> peopleFilterEnumList;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<bloc.Bloc, bloc.State>(builder: (context, state) {
      return SizedBox(
        width: size.width * 0.85,
        height: size.height * 0.055,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: peopleFilterEnumList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                context.read<bloc.Bloc>().add(
                      bloc.SelectFilterEvent(peopleFilterEnumList[index].value),
                    );
              },
              child: Transform(
                transform: Matrix4.identity()..scale(0.8),
                child: Chip(
                  backgroundColor:
                      state.model.filter == peopleFilterEnumList[index].value
                          ? Colors.orange
                          : Colors.orange.withOpacity(0.7),
                  label: Text(
                    peopleFilterEnumList[index].value,
                    style: TextStyle(
                      fontSize: size.width * 0.035,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
