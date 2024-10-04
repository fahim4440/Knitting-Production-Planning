import 'package:flutter/material.dart';
import 'package:knitting_production_planning/widget/filter_button_plannerpage.dart';
import '../bloc/planner_page_bloc/plannerpage_bloc.dart';
import 'new_order_alert_dialog.dart';

Row ListOfFilterButtonsPlannerpage(BuildContext context, PlannerpageLoadedState state) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(width: 10.0,),
      FilterButtonPlannerpage(context, state, "All"),
      const SizedBox(width: 10.0,),
      FilterButtonPlannerpage(context, state, "Pending"),
      const SizedBox(width: 10.0,),
      FilterButtonPlannerpage(context, state, "Running"),
      const SizedBox(width: 10.0,),
      FilterButtonPlannerpage(context, state, "Closed"),
      const SizedBox(width: 10.0,),
      FilterButtonPlannerpage(context, state, "Cancelled"),
    ],
  );
}