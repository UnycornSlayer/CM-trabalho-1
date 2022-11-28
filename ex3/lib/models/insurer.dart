import 'contract.dart';

class Insurer {
  String name;
  List<Contract> activeContracts;

  Insurer(this.name, this.activeContracts);

  @override
  String toString() => '$name has this active contracts: $activeContracts';
}
