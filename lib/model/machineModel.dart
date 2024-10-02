class Machine {
  final int machineNumber;
  final int dia;
  final int gauge;
  final String machineBrand;
  final MachineType machineType;
  final Floor floorName;

  Machine({
    required this.machineNumber,
    required this.dia,
    required this.gauge,
    required this.machineBrand,
    required this.machineType,
    required this.floorName,
  });

  Map<String, dynamic> toJson() {
    return {
      'machineNumber': machineNumber,
      'dia': dia,
      'gauge': gauge,
      'machineBrand': machineBrand,
      'machineType': machineType,
      'floorName': floorName,
    };
  }

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      machineNumber: json['machineNumber'],
      dia: json['dia'],
      gauge: json['gauge'],
      machineBrand: json['machineBrand'],
      machineType: json['machineType'],
      floorName: json['floorName'],
    );
  }
}

enum MachineType {
  Single_Jersey,
  Double_Jersey,
  Single_Jersey_Autostripe,
  Double_Jersey_Autostripe,
  Fleece,
  Double_Jersey_Jacquard,
  Single_Jersey_Jacquard,
}

enum Floor {
  EFL,
  EKL,
  EFL_Extension,
  YD,
  ESL_Extension,
}
