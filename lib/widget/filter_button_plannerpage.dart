import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knitting_production_planning/bloc/planner_page_bloc/plannerpage_bloc.dart';

MaterialButton FilterButtonPlannerpage(BuildContext context, PlannerpageLoadedState state, String filter) {
  return MaterialButton(
    onPressed: () {
      context.read<PlannerpageBloc>().add(FilterOrdersPlannerpageEvent(filter));
    },
    color: state.currentFilter == filter ? Colors.blue : Colors.lightBlue[50],
    child: Text(filter),
  );
}