import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knitting_production_planning/widget/buyer_list_homepage.dart';
import 'package:knitting_production_planning/widget/data_table_homepage.dart';
import 'package:knitting_production_planning/widget/header.dart';
import 'package:knitting_production_planning/widget/list_of_filter_buttons_homepage.dart';
import '../bloc/homepage_bloc/homepage_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // _initializeDatabases();
    // final OrderDatabase _orderDatabase = OrderDatabase.instance;
    // _orderDatabase.deleteOrderDatabase();
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
            BlocBuilder<HomepageBloc, HomepageState>(
              builder: (context, state) {
                if (state is HomepageLoadedState) {
                  return HomepageLoadedUI(state);
                } else if (state is HomePageError) {
                  return Center(child: Text(state.error),);
                } else if (state is HomepageLoadingState) {
                  return const Center(child: CircularProgressIndicator(),);
                } else if (state is HomepageInitialState) {
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

  SizedBox HomepageLoadedUI(HomepageLoadedState state) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuyerListHomepage(context, buyerList, state),
          const VerticalDivider(color: Colors.black, width: 30, thickness: 2.0,),
          Container(
            width: MediaQuery.of(context).size.width - 180.0,
            height: MediaQuery.of(context).size.height - 70,
            color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0,),
                ListOfFilterButtonsHomepage(context, state),
                const SizedBox(height: 10.0,),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTableExcelHomepage(state),
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