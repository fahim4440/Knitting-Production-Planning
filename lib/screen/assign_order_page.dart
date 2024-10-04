import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knitting_production_planning/screen/signin_page.dart';
import 'package:knitting_production_planning/widget/data_table_assign_page.dart';
import '../bloc/assign_order_page_bloc/assign_order_page_bloc.dart';
import '../model/machine_model.dart';
import '../widget/header.dart';

class AssignOrderPage extends StatefulWidget {
  final MachineType machineType;
  const AssignOrderPage({super.key, required this.machineType});

  @override
  State<AssignOrderPage> createState() => _AssignOrderPageState();
}

class _AssignOrderPageState extends State<AssignOrderPage> {

  @override
  void initState() {
    super.initState();
    context.read<AssignOrderPageBloc>().add(FetchMachinesByTypeEvent(machineType: widget.machineType));
  }

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
            BlocBuilder<AssignOrderPageBloc, AssignOrderPageState>(
              builder: (context, state) {
                if (state is AssignOrderPageLoaded) {
                  return AssignpageLoadedUI(state);
                } else if (state is AssignOrderPageError) {
                  return Center(child: Text(state.error),);
                } else if (state is AssignOrderPageLoading) {
                  return const Center(child: CircularProgressIndicator(),);
                } else if (state is AssignOrderPageInitial) {
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

  Container AssignpageLoadedUI(AssignOrderPageLoaded state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 70,
      color: Colors.amber,
      child: Row(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTableExcelAssignpage(state, context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
