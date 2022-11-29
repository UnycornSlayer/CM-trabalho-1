import 'package:ex3/data/insurers.dart';
import 'package:ex3/exceptions/already_existing_item_exception.dart';
import 'package:ex3/exceptions/doesnt_exist_on_list_exception.dart';
import 'package:ex3/models/contract.dart';
import 'package:ex3/models/insurer.dart';
import 'package:ex3/models/person.dart';
import 'package:intl/intl.dart';

void main(List<String> arguments) {
  Insurers insurers = Insurers();
  try {
    insurers.add(
      Insurer(0, 'ok teleseguros', [], []),
    );
    insurers.add(
      Insurer(1, 'fidelidade', [], []),
    );
    insurers.add(
      Insurer(2, 'nmldmn', [], []),
    );
  } on AlreadyExistingItemException catch (e, f) {
    print(e.errorMessage());
    print(f);
  } on DoesntExistOnListException catch (e, f) {
    print(e.errorMessage());
    print(f);
  }

  List<Person> clients = [
    Person(0, 'Miguel', 22, 'Rua de baixo', null),
    Person(1, 'Pedro', 21, 'Rua de cima', null),
    Person(2, 'Telmo', 23, 'Rua da esquerda', null)
  ];

  List<Contract> contracts = [
    Contract(0, 'health', DateTime(2023 - 5 - 15), 8000, clients[0].name,
        insurers.list[0], clients[0]),
    Contract(1, 'car', DateTime(2024 - 1 - 1), 10000, 'BMW Series 1',
        insurers.list[1], clients[1]),
    Contract(2, 'life', DateTime(2022 - 12 - 31), 12000, clients[0].name,
        insurers.list[2], clients[2])
  ];

  insurers.addContract(contracts[0], insurers.list[0]);
  insurers.addContract(contracts[1], insurers.list[1]);
  // print(insurers.list);
  print(
      'Quantity of active contracts: ${insurers.quantityActiveContracts(insurers.list[0])}');
  print('Average income: ${insurers.averageIncome(insurers.list[0])}');
}

void printLists(List list) {
  print('------- SUMMARY (finally block) -------');
  list.forEach((s) => print(s));
}
