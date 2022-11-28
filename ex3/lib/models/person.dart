import 'package:ex3/models/contract.dart';

class Person {
  int id;
  String name;
  List<Contract> activeContracts;

  Person(this.id, this.name, this.activeContracts);

  @override
  String toString() => 'Id: $id , Name: $name,'
      '${activeContracts.isNotEmpty ? 'Active contracts: $activeContracts' : ''}';
}
