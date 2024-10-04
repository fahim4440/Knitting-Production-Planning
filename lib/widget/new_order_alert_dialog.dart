import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/homepage_bloc/homepage_bloc.dart';
import '../model/machine_model.dart';
import '../model/order_model.dart';
import 'input_text_field.dart';

class NewOrderAlertDialog extends StatefulWidget {
  const NewOrderAlertDialog({super.key});

  @override
  State<NewOrderAlertDialog> createState() => _NewOrderAlertDialogState();
}

class _NewOrderAlertDialogState extends State<NewOrderAlertDialog> {
  final TextEditingController _orderNoController = TextEditingController();
  final TextEditingController _buyerNameController = TextEditingController();
  final TextEditingController _fabricTypeController = TextEditingController();
  final TextEditingController _compositionController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _diaController = TextEditingController();
  final TextEditingController _gaugeController = TextEditingController();
  final TextEditingController _finishedGSMController = TextEditingController();
  final TextEditingController _finishedWidthController = TextEditingController();
  final TextEditingController _stitchLengthController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _spinnerController = TextEditingController();
  final TextEditingController _lotController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  FabricOpenType? _selectedFabricOpenType;
  MachineType? _selectedMachineType;
  DateTime? _selectedClosingDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Add New Order")),
      content: SizedBox(
        height: MediaQuery.of(context).size.height - 300,
        width: MediaQuery.of(context).size.width - 300,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputTextField(_orderNoController, "Order Number"),
              const SizedBox(height: 10.0,),
              InputTextField(_buyerNameController, "Buyer Name"),
              const SizedBox(height: 10.0,),
              InputTextField(_fabricTypeController, "Fabric Type"),
              const SizedBox(height: 10.0,),
              InputTextField(_compositionController, "Fabric Composition"),
              const SizedBox(height: 10.0,),
              InputTextField(_colorController, "Color"),
              const SizedBox(height: 10.0,),
              InputTextField(_diaController, "Dia"),
              const SizedBox(height: 10.0,),
              InputTextField(_gaugeController, "Gauge"),
              const SizedBox(height: 10.0,),
              InputTextField(_finishedGSMController, "Finished GSM"),
              const SizedBox(height: 10.0,),
              InputTextField(_finishedWidthController, "Finished Width"),
              const SizedBox(height: 10.0,),
              Row(
                children: [
                  const Text("Fabric Open Type: "),
                  DropdownButton<FabricOpenType>(
                    value: _selectedFabricOpenType,
                    hint: const Text("Select Fabric Open Type"),
                    items: FabricOpenType.values.map((FabricOpenType type) {
                      return DropdownMenuItem<FabricOpenType>(
                        value: type,
                        child: Text(type.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (FabricOpenType? newValue) {
                      setState(() {
                        _selectedFabricOpenType = newValue;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10.0,),
              InputTextField(_stitchLengthController, "SL"),
              const SizedBox(height: 10.0,),
              InputTextField(_countController, "Count"),
              const SizedBox(height: 10.0,),
              InputTextField(_spinnerController, "Spinner"),
              const SizedBox(height: 10.0,),
              InputTextField(_lotController, "Lot"),
              const SizedBox(height: 10.0,),
              Row(
                children: [
                  const Text("Machine Type: "),
                  DropdownButton<MachineType>(
                    value: _selectedMachineType,
                    hint: const Text("Select Machine Type"),
                    items: MachineType.values.map((MachineType type) {
                      return DropdownMenuItem<MachineType>(
                        value: type,
                        child: Text(type.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (MachineType? newValue) {
                      setState(() {
                        _selectedMachineType = newValue;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10.0,),
              InputTextField(_quantityController, "Quantity"),
              const SizedBox(height: 10.0,),
              Row(
                children: [
                  const Text("Closing Date: "),
                  Text(
                    _selectedClosingDate == null
                        ? "Select Closing Date"
                        : _selectedClosingDate!.toLocal().toString().split(' ')[0],
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _selectedClosingDate = pickedDate;
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            // Trigger AddNewOrderEvent with all inputs
            if (_orderNoController.text.isNotEmpty && _buyerNameController.text.isNotEmpty && _fabricTypeController.text.isNotEmpty && _compositionController.text.isNotEmpty && _colorController.text.isNotEmpty && _diaController.text.isNotEmpty && _gaugeController.text.isNotEmpty && _finishedGSMController.text.isNotEmpty && _finishedWidthController.text.isNotEmpty && _fabricTypeController.text.isNotEmpty &&  _selectedFabricOpenType != null && _stitchLengthController.text.isNotEmpty && _countController.text.isNotEmpty && _lotController.text.isNotEmpty && _spinnerController.text.isNotEmpty && _selectedMachineType != null && _quantityController.text.isNotEmpty && _selectedClosingDate != null) {
              Order order = Order(orderNo: _orderNoController.text.trim(), buyerName: _buyerNameController.text.trim(), fabricType: _fabricTypeController.text.trim(), composition: _compositionController.text.trim(), color: _colorController.text.trim(), dia: int.parse(_diaController.text.trim()), gauge: int.parse(_gaugeController.text.trim()), finishedGSM: int.parse(_finishedGSMController.text.trim()), finishedWidth: int.parse(_finishedWidthController.text.trim()), openType: _selectedFabricOpenType!, stitchLength: _spinnerController.text.trim(), count: _countController.text.trim(), spinner: _spinnerController.text.trim(), lot: _lotController.text.trim(), machineType: _selectedMachineType!, quantity: double.parse(_quantityController.text.trim()), balance: double.parse(_quantityController.text.trim()), status: OrderStatus.Pending, orderClosingDate: _selectedClosingDate!);
              print(order.buyerName);
              context.read<HomepageBloc>().add(AddNewOrderEvent(order));
              Navigator.of(context).pop();
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
