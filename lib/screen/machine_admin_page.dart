import 'package:flutter/material.dart';
import 'package:knitting_production_planning/widget/header.dart';

class MachineAdminPage extends StatefulWidget {
  const MachineAdminPage({super.key});

  @override
  _MachineAdminPageState createState() => _MachineAdminPageState();
}

class _MachineAdminPageState extends State<MachineAdminPage> {
  List<String> floors = ["Floor 1", "Floor 2", "Floor 3"];
  String selectedFloor = "Floor 1";
  List<Map<String, String>> machines = [];
  Map<String, String>? editingMachine;

  void _addMachineDialog() {
    TextEditingController numberController = TextEditingController();
    TextEditingController typeController = TextEditingController();
    TextEditingController diaController = TextEditingController();
    TextEditingController gaugeController = TextEditingController();
    TextEditingController brandController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Machine"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: numberController,
                decoration: const InputDecoration(labelText: "Machine Number")),
            TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: "Machine Type")),
            TextField(
                controller: diaController,
                decoration: const InputDecoration(labelText: "Diameter")),
            TextField(
                controller: gaugeController,
                decoration: const InputDecoration(labelText: "Gauge")),
            TextField(
                controller: brandController,
                decoration: const InputDecoration(labelText: "Brand")),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                machines.add({
                  "number": numberController.text,
                  "type": typeController.text,
                  "dia": diaController.text,
                  "gauge": gaugeController.text,
                  "brand": brandController.text,
                });
              });
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _editMachine(int index) {
    setState(() {
      editingMachine = machines[index];
    });
  }

  void _saveMachine(int index) {
    setState(() {
      editingMachine = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context),
      body: Row(
        children: [
          Container(
            width: 200,
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text("Floor List", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,))),
                ),
                Expanded(
                  child: ListView(
                    children: floors.map((floor) {
                      return ListTile(
                        title: Text(floor),
                        selected: floor == selectedFloor,
                        onTap: () {
                          setState(() {
                            selectedFloor = floor;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Machines in $selectedFloor",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      ElevatedButton(
                          onPressed: _addMachineDialog,
                          child: const Text("Add Machine")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: machines.length,
                      itemBuilder: (context, index) {
                        bool isEditing = editingMachine == machines[index];
                        return ListTile(
                            leading: IconButton(
                              icon: Icon(isEditing ? Icons.save : Icons.edit),
                              onPressed: () {
                                isEditing
                                    ? _saveMachine(index)
                                    : _editMachine(index);
                              },
                            ),
                            title: isEditing
                                ? TextField(
                                    controller: TextEditingController(
                                        text: machines[index]['number']),
                                    onChanged: (value) =>
                                        machines[index]['number'] = value,
                                  )
                                : Text(
                                    "Machine: ${machines[index]['number']}, Type: ${machines[index]['type']}"));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
