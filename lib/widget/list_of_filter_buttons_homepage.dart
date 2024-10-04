import 'package:flutter/material.dart';

import '../bloc/homepage_bloc/homepage_bloc.dart';
import 'filter_button_homepage.dart';
import 'new_order_alert_dialog.dart';

Row ListOfFilterButtonsHomepage(BuildContext context, HomepageLoadedState state) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      MaterialButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const NewOrderAlertDialog();
              }
          );
        },
        color: Colors.lightBlue[50],
        child: const Text("New"),
      ),
      const SizedBox(width: 10.0,),
      FilterButtonHomepage(context, state, "All"),
      const SizedBox(width: 10.0,),
      FilterButtonHomepage(context, state, "Pending"),
      const SizedBox(width: 10.0,),
      FilterButtonHomepage(context, state, "Running"),
      const SizedBox(width: 10.0,),
      FilterButtonHomepage(context, state, "Closed"),
      const SizedBox(width: 10.0,),
      FilterButtonHomepage(context, state, "Cancelled"),
    ],
  );
}