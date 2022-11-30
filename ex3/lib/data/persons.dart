import 'dart:io';

import '../exceptions/already_existing_item_exception.dart';
import '../exceptions/cannot_delete_element_with_active_contracts.dart';
import '../exceptions/doesnt_exist_on_list_exception.dart';
import '../models/contract.dart';
import '../models/person.dart';

class Persons {
  final List<Person> _persons = [];

  List<Person> get list => _persons;

  /// Add a person to a list os persons
  /// @params Person person
  void add(Person person) {
    if (_persons.any((p) => p.id == person.id)) {
      throw AlreadyExistingItemException(
          'data/students[_students list]', person.id.toString());
    }
    _persons.add(person);
  }

  /// Update an existing person from the List of persons
  /// @params Person person
  void update(Person person) {
    int index = _persons.indexWhere((p) => p.id == person.id);

    if (index == -1) {
      print(index);
      throw DoesntExistOnListException(
          'data/students[_students list]', person.id.toString());
    }
    _persons[index] = person;
  }

  /// Delete a person from the List of persons
  /// @params Person person
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

  /// Report for every person with info about their active contracts
  /// @params Persons clients
  void entityReport(Persons persons) {
    print(
        '\x1b[1m----------------------------------------------------------------------------------\n'
        '                            Entities Report\n'
        '----------------------------------------------------------------------------------');
    print('Name\t Age\t    Address\t Insurer\t Type\t Insured\t Fee\n'
        '----------------------------------------------------------------------------------\x1b[0m');
    for (Person person in persons.list) {
      for (Contract contract in person.contracts) {
        stdout.write('${person.name.padRight(5)}\t');
        stdout.write('${person.age.toStringAsFixed(1).padRight(7)}\t');
        stdout.write('${person.address.padRight(10)}\t');
        stdout.write('${contract.insurer.name.padRight(10)}\t');
        stdout.write('${contract.type.padRight(5)}\t');
        stdout.write('${contract.insured.padRight(10)}\t');
        stdout.write('${contract.anualFee.toStringAsFixed(2).padLeft(8)} €');
        print("");
      }
    }
    print(
        '\x1b[1m--------------------------------End of report-------------------------------------\x1b[0m');
  }

  /// List every person object
  void listPersons() {
    print('\x1b[1m-----------------------------------------------------------\n'
        '                        Clients List\n'
        '-----------------------------------------------------------');
    print('Id\tName\t Age\t    Address\t  Active Contracts\n'
        '-----------------------------------------------------------\x1b[0m');
    // ignore: avoid_function_literals_in_foreach_calls
    _persons.forEach((p) {
      stdout.write('${p.id.toStringAsFixed(0).padRight(5)}\t');
      stdout.write('${p.name.padRight(6)}\t');
      stdout.write('${p.age.toStringAsFixed(0).padRight(5).padLeft(6)}\t');
      stdout.write('${p.address.padRight(20)}\t');
      stdout.write('${p.contracts.length.toStringAsFixed(0).padRight(10)}\t');
      print("");
    });
    print(
        '\x1b[1m-------------------------End of List-----------------------\x1b[0m');
  }
}
