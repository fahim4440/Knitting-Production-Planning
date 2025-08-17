import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knitting_production_planning/bloc/floor_page_bloc/floor_page_bloc.dart';
import 'package:knitting_production_planning/model/machine_model.dart';
import 'package:knitting_production_planning/widget/data_table_floorpage.dart';
import 'package:knitting_production_planning/widget/header.dart';

class FloorPage extends StatefulWidget {
  final Floor floorName;
  const FloorPage({super.key, required this.floorName});

  @override
  State<FloorPage> createState() => _FloorPageState();
}

class _FloorPageState extends State<FloorPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FloorPageBloc>(context)
        .add(FloorPageFetchOrderByMachineEvent(floorName: widget.floorName));
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
            BlocBuilder<FloorPageBloc, FloorPageState>(
              builder: (context, state) {
                if (state is FloorPageLoadedState) {
                  return floorPageLoadedUI(state, context);
                } else if (state is FloorPageErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                } else if (state is FloorPageLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FloorPageInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox floorPageLoadedUI(FloorPageLoadedState state, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 56,
            color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTableExcelFloorpage(state, context),
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
