import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knitting_production_planning/bloc/assign_order_page_bloc/assign_order_page_bloc.dart';
import 'package:knitting_production_planning/bloc/floor_page_bloc/floor_page_bloc.dart';
import 'package:knitting_production_planning/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:knitting_production_planning/bloc/planner_page_bloc/plannerpage_bloc.dart';
import 'package:knitting_production_planning/model/machine_model.dart';
import 'package:knitting_production_planning/screen/floor_page.dart';
import 'screen/planner_page.dart';
import 'screen/home_page.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (BuildContext context) => HomepageBloc()..add(const FetchOrdersEvent()),
      ),
      BlocProvider(
        create: (BuildContext context) => PlannerpageBloc()..add(const FetchOrdersPlannerpageEvent()),
      ),
      BlocProvider(
        create: (BuildContext context) => AssignOrderPageBloc(),
      ),
      BlocProvider(
        create: (BuildContext context) => FloorPageBloc()..add(const FloorPageFetchOrderByMachineEvent(floorName: Floor.EFL)),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Knitting Production & Planning',
      home: FloorPage(),
    );
  }
}