import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:knitting_production_planning/model/machineModel.dart';
import 'package:knitting_production_planning/model/order_model.dart';
import 'package:knitting_production_planning/screen/signin_page.dart';
import '../widget/cell_container.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> buyerList = ["M&S", "Express", "Tommy Hillfiger", "Next"];

  final ScrollController _horizontalScrollController = ScrollController();

  final ScrollController _verticalScrollController = ScrollController();

  final List<Order> _data = [
    Order(
        orderNo: 250504,
        buyerName: "Express",
        fabricType: "Design Jersey",
        composition: "100% Cotton",
        color: "White",
        dia: 30,
        gauge: 24,
        finishedGSM: 180,
        finishedWidth: 72,
        openType: FabricOpenType.Needle_Open,
        stitchLength: "2.70",
        count: "30CC",
        spinner: "PT. Indoarama",
        lot: "12345",
        machineType: MachineType.Single_Jersey,
        quantity: 1500,
        balance: 1500,
        status: OrderStatus.Pending,
        orderClosingDate: DateTime(2024, 02, 17)),
  ];

  final List<DataColumn2> headerColumn = [
    DataColumn2(label: cellContainer("Order No"), numeric: true, size: ColumnSize.L),
    DataColumn2(label: cellContainer("Buyer Name"), size: ColumnSize.L),
    DataColumn2(label: cellContainer("Fabric Type"), size: ColumnSize.L),
    DataColumn2(label: cellContainer("Composition"), size: ColumnSize.L),
    DataColumn2(label: cellContainer("Color"), size: ColumnSize.L),
    DataColumn2(label: cellContainer("Dia"), numeric: true, size: ColumnSize.S),
    DataColumn2(label: cellContainer("Gauge"), numeric: true, size: ColumnSize.S),
    DataColumn2(label: cellContainer("Finished Width",), numeric: true, size: ColumnSize.S),
    DataColumn2(label: cellContainer("Finished GSM"), numeric: true, size: ColumnSize.S),
    DataColumn2(label: cellContainer("Open Type"), size: ColumnSize.L),
    DataColumn2(label: cellContainer("Stitch Length"), size: ColumnSize.L),
    DataColumn2(label: cellContainer("Count"), size: ColumnSize.L),
    DataColumn2(label: cellContainer("Spinner"), size: ColumnSize.M),
    DataColumn2(label: cellContainer("Lot"), size: ColumnSize.L),
    DataColumn2(label: cellContainer("Machine Type"), size: ColumnSize.L),
    DataColumn2(label: cellContainer("Running Machines"), size: ColumnSize.S),
    DataColumn2(label: cellContainer("Quantity"), size: ColumnSize.S),
    DataColumn2(label: cellContainer("Balance"), size: ColumnSize.S),
    DataColumn2(label: cellContainer("Status"), size: ColumnSize.M),
    DataColumn2(label: cellContainer("Order Closing Date"), size: ColumnSize.L),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[70],
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Header(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuyerList(
                    buyerList: buyerList,
                  ),
                  const VerticalDivider(
                    color: Colors.black,
                    width: 30,
                    thickness: 2.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 180.0,
                    height: MediaQuery.of(context).size.height - 70,
                    color: Colors.amber,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                setState(() {
                                  _data.add(Order(
                                    orderNo: 254005,
                                    buyerName: "M&S",
                                    fabricType: "STBPQ",
                                    composition: "96% Cotton 4% Elastane",
                                    color: "Stone",
                                    dia: 30,
                                    gauge: 24,
                                    finishedGSM: 180,
                                    finishedWidth: 70,
                                    openType: FabricOpenType.Blade_Open,
                                    stitchLength: "2.75",
                                    count: "30CC + 40DSP",
                                    spinner: "Square",
                                    lot: "926GTR2",
                                    machineType: MachineType.Single_Jersey,
                                    quantity: 5000,
                                    balance: 5000,
                                    status: OrderStatus.Pending,
                                    orderClosingDate: DateTime(2025, 2, 10)));
                                });
                              },
                              color: Colors.lightBlue[50],
                              child: const Text("New"),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            MaterialButton(
                              onPressed: () {},
                              color: Colors.lightBlue[50],
                              child: const Text("All"),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            MaterialButton(
                              onPressed: () {},
                              color: Colors.lightBlue[50],
                              child: const Text("Pending"),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            MaterialButton(
                              onPressed: () {},
                              color: Colors.lightBlue[50],
                              child: const Text("Running"),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            MaterialButton(
                              onPressed: () {},
                              color: Colors.lightBlue[50],
                              child: const Text("Closed"),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            MaterialButton(
                              onPressed: () {},
                              color: Colors.lightBlue[50],
                              child: const Text("Dropped"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 180,
                          height: MediaQuery.of(context).size.height - 118,
                          child: DataTable2(
                            columnSpacing: 12,
                            headingRowHeight: 80,
                            horizontalScrollController:
                                _horizontalScrollController,
                            scrollController: _verticalScrollController,
                            isHorizontalScrollBarVisible: true,
                            border:
                                TableBorder.all(width: 1.0, color: Colors.grey),
                            columns: headerColumn,
                            rows: _data.map((order) {
                              return DataRow(cells: [
                                DataCell(
                                    cellContainer(order.orderNo.toString())),
                                DataCell(cellContainer(order.buyerName)),
                                DataCell(cellContainer(order.fabricType)),
                                DataCell(cellContainer(order.composition)),
                                DataCell(cellContainer(order.color)),
                                DataCell(cellContainer(order.dia.toString())),
                                DataCell(cellContainer(order.gauge.toString())),
                                DataCell(cellContainer(
                                    order.finishedWidth.toString())),
                                DataCell(cellContainer(
                                    order.finishedGSM.toString())),
                                DataCell(cellContainer(
                                    order.openType.toString().split(".").last)),
                                DataCell(cellContainer(order.stitchLength)),
                                DataCell(cellContainer(order.count)),
                                DataCell(cellContainer(order.spinner)),
                                DataCell(cellContainer(order.lot)),
                                DataCell(cellContainer(order.machineType
                                    .toString()
                                    .split(".")
                                    .last)),
                                order.runningMachine == null
                                    ? const DataCell(Text(""))
                                    : DataCell(cellContainer(order
                                        .runningMachine!.length
                                        .toString())),
                                DataCell(
                                    cellContainer(order.quantity.toString())),
                                DataCell(
                                    cellContainer(order.balance.toString())),
                                DataCell(cellContainer(
                                    order.status.toString().split(".").last)),
                                DataCell(
                                    cellContainer(order.orderClosingDate.toString().substring(0,10))),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70.0,
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 5.0,
        bottom: 5.0,
      ),
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Knitting Production & Planning",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SigninPage()),
                (Route<dynamic> route) => false,
              );
            },
            color: Colors.lightBlue[50],
            child: const Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}

class BuyerList extends StatelessWidget {
  List<String> buyerList;

  BuyerList({required this.buyerList, super.key});

  @override
  Widget build(BuildContext context) {
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
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(left: 5.0),
                        height: 30.0,
                        width: 150.0,
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
}
