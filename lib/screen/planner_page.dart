import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knitting_production_planning/database/machine_db_helper.dart';
import 'package:knitting_production_planning/database/order_db_helper.dart';
import 'package:knitting_production_planning/database/order_wise_running_machine_db_helper.dart';
import '../widget/buyer_list_planner_page.dart';
import '../widget/data_table_plannerpage.dart';
import '../widget/list_of_filter_buttons_plannerpage.dart';
import '../widget/header.dart';
import '../bloc/planner_page_bloc/plannerpage_bloc.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {

  @override
  void initState() {
    OrderWiseRunningMachineDbHelper().instance.database;
    OrderDbHelper().instance.database;
    MachineDbHelper().instance.database;
    super.initState();
  }

  final List<String> buyerList = ["M&S", "Express", "Tommy Hillfiger", "Next"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context),
      backgroundColor: Colors.blueAccent[70],
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Header(context),
            BlocBuilder<PlannerpageBloc, PlannerpageState>(
              builder: (context, state) {
                if (state is PlannerpageLoadedState) {
                  return PlannerpageLoadedUI(state);
                } else if (state is PlannerpageError) {
                  return Center(child: Text(state.error),);
                } else if (state is PlannerpageLoadingState) {
                  return const Center(child: CircularProgressIndicator(),);
                } else if (state is PlannerpageInitial) {
                  return const Center(child: CircularProgressIndicator(),);
                }
                return const Center(child: CircularProgressIndicator(),);
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox PlannerpageLoadedUI (PlannerpageLoadedState state) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuyerListPlannerpage(context, buyerList, state),
          const VerticalDivider(
            color: Colors.black, width: 30, thickness: 2.0,),
          Container(
            width: MediaQuery.of(context).size.width - 180.0,
            height: MediaQuery.of(context).size.height - 70,
            color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0,),
                ListOfFilterButtonsPlannerpage(context, state),
                const SizedBox(height: 10.0,),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTableExcelPlannerpage(state, context),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
