import 'package:ex3/data/insurers.dart';
import 'package:ex3/exceptions/already_existing_item_exception.dart';
import 'package:ex3/models/contract.dart';
import 'package:ex3/models/insurer.dart';
import 'package:ex3/models/person.dart';
import 'package:intl/intl.dart';

void main(List<String> arguments) {
  // List<Insurer> insurers = [
  //   Insurer(0, 'okteleseguros', null, null),
  //   Insurer(1, 'fidelidade', null, null),
  //   Insurer(2, 'nmldmn', null, null)
  // ];

  Insurers insurers = Insurers();
  try {
    insurers.add(
      Insurer(0, 'ok teleseguros', null, null),
    );
    insurers.add(
      Insurer(1, 'fidelidade', null, null),
    );
    insurers.add(
      Insurer(2, 'nmldmn', null, null),
    );
  } on AlreadyExistingItemException catch (e, f) {
    print(e.errorMessage());
    print(f);
  }

  printLists(insurers.list);

  List<Person> clients = [
    Person(0, 'Miguel', 22, 'Rua de baixo', null),
    Person(1, 'Pedro', 21, 'Rua de cima', null),
    Person(2, 'Telmo', 23, 'Rua da esquerda', null)
  ];

  // List<Contract> contracts = [
  //   Contract('health', DateTime(2023 - 5 - 15), 8000, clients[0].name,
  //       insurers[0], clients[0]),
  //   Contract('car', DateTime(2024 - 1 - 1), 10000, 'BMW Series 1', insurers[1],
  //       clients[1]),
  //   Contract('life', DateTime(2022 - 12 - 31), 12000, clients[0].name,
  //       insurers[2], clients[2])
  // ];
}

void printLists(List list) {
  print('------- SUMMARY (finally block) -------');
  list.forEach((s) => print(s));
}
