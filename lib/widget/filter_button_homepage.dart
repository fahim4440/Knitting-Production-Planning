import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/homepage_bloc/homepage_bloc.dart';

MaterialButton FilterButtonHomepage(BuildContext context, HomepageLoadedState state, String filter) {
  return MaterialButton(
    onPressed: () {
      context.read<HomepageBloc>().add(FilterOrdersEvent(filter));
    },
    color: state.currentFilter == filter ? Colors.blue : Colors.lightBlue[50],
    child: Text(filter),
  );
}