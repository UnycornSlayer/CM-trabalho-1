import 'dart:io';

import 'package:ex3/models/contract.dart';

import '../exceptions/already_existing_item_exception.dart';
import '../exceptions/cannot_delete_element_with_active_contracts.dart';
import '../exceptions/doesnt_exist_on_list_exception.dart';
import '../models/person.dart';

class Persons {
  final List<Person> _persons = [];

  List<Person> get list => _persons;

  void add(Person person) {
    if (_persons.any((p) => p.id == person.id)) {
      throw AlreadyExistingItemException(
          'data/students[_students list]', person.id.toString());
    }
    _persons.add(person);
  }

  void update(Person person) {
    int index = _persons.indexWhere((p) => p.id == person.id);

    if (index == -1) {
      print(index);
      throw DoesntExistOnListException(
          'data/students[_students list]', person.id.toString());
    }
    _persons[index] = person;
  }

  void delete(Person person) {
    int index = _persons.indexWhere((p) => p.id == person.id);

    if (index == -1) {
      print(index);
      throw DoesntExistOnListException(
          'data/students[_students list]', person.id.toString());
    } else if (person.contracts.isNotEmpty) {
      throw CannotDeleteElementWithActiveContracts(
          'data/persons[_persons list]', person.name);
    }
    _persons.removeAt(index);
  }

  void entityReport(Persons clients) {
    print(
        '\x1b[1m----------------------------------------------------------------------------------\n'
        '                            Entities Report\n'
        '----------------------------------------------------------------------------------');
    print('Name\t Age\t    Address\t Insurer\t Type\t Insured\t Fee\n'
        '----------------------------------------------------------------------------------\x1b[0m');
    for (Person client in clients.list) {
      for (Contract contract in client.contracts) {
        stdout.write('${client.name.padRight(5)}\t');
        stdout.write('${client.age.toStringAsFixed(1).padRight(7)}\t');
        stdout.write('${client.address.padRight(10)}\t');
        stdout.write('${contract.insurer.name.padRight(10)}\t');
        stdout.write('${contract.type.padRight(5)}\t');
        stdout.write('${contract.insured.padRight(10)}\t');
        stdout.write('${contract.anualFee.toStringAsFixed(2).padLeft(8)} €');
        print("");
      }
    }
    print(
        '--------------------------------End of report-------------------------------------\x1b[0m');
  }
}
