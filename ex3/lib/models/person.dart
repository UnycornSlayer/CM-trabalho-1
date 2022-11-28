import 'package:ex3/models/contract.dart';

class Person {
  int id;
  String name;
  int age;
  String address;
  List<Contract>? activeContracts;

  Person(this.id, this.name, this.age, this.address, this.activeContracts);

  @override
  String toString() => 'Id: $id , Name: $name,'
      '${activeContracts != null ? 'Active contracts: $activeContracts' : ''}';
}
