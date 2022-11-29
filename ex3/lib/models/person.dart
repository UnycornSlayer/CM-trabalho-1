import 'package:ex3/models/contract.dart';

class Person {
  int id;
  String name;
  int age;
  String address;
  List<Contract> contracts;

  Person(this.id, this.name, this.age, this.address, this.contracts);

  @override
  String toString() => 'Id: $id , Name: $name,'
      '${contracts.isNotEmpty ? 'Active contracts: $contracts' : ''}';
}
