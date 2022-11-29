import 'contract.dart';

class Insurer {
  int id;
  String name;
  List<Contract> activeContracts;
  List<Contract> inactiveContracts;

  Insurer(this.id, this.name, this.activeContracts, this.inactiveContracts);

  @override
  String toString() =>
      '\n$name ${activeContracts.isNotEmpty ? 'has this active contracts: $activeContracts .' : 'has no active contracts. \n'}';
}
