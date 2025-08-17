import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knitting_production_planning/bloc/planner_page_bloc/plannerpage_bloc.dart';

SizedBox BuyerListPlannerpage(BuildContext context, List<String> buyerList, PlannerpageLoadedState state) {
  return SizedBox(
    height: MediaQuery.of(context).size.height - 70,
    width: 150,
    child: Column(
      children: [
        const Text(
          "Buyer List",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(
          color: Colors.black,
          height: 3.0,
          thickness: 2.0,
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: buyerList.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<PlannerpageBloc>().add(SelectBuyerPlannerpageEvent(buyerList[index]));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 5.0),
                      height: 30.0,
                      width: 150.0,
                      color: buyerList[index] == state.selectedBuyer ? Colors.blue : Colors.transparent,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        buyerList[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 2.0,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}