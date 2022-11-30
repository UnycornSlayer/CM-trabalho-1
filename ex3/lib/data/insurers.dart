import 'package:ex3/exceptions/cannot_delete_element_with_active_contracts.dart';
import 'dart:io';
import '../exceptions/already_existing_item_exception.dart';
import '../exceptions/doesnt_exist_on_list_exception.dart';
import '../models/insurer.dart';

class Insurers {
  final List<Insurer> _insurers = [];

  List<Insurer> get list => _insurers;

  /// Add an insurer to a list os insurers
  /// @params Insurer insurer
  void add(Insurer insurer) {
    if (_insurers.any((i) => i.id == insurer.id)) {
      throw AlreadyExistingItemException(
          'data/insurers[_insurers list]', insurer.id.toString());
    }
    _insurers.add(insurer);
  }

  /// Update an existing insurer from the List of insurers
  /// @params Insurer insurer
  void update(Insurer insurer) {
    int index = _insurers.indexWhere((i) => i.id == insurer.id);

    if (index == -1) {
      throw DoesntExistOnListException(
          'data/insurers[_insurers list]', insurer.id.toString());
    }
    _insurers[index] = insurer;
  }

  /// Delete an insurer from the List of insurers
  /// @params Insurer insurer
  void delete(Insurer insurer) {
    int index = _insurers.indexWhere((i) => i.id == insurer.id);
    //print(insurer.activeContracts);
    if (index == -1) {
      throw DoesntExistOnListException(
          'data/insurers[_insurers list]', insurer.id.toString());
    } else if (insurer.activeContracts.isNotEmpty) {
      throw CannotDeleteElementWithActiveContracts(
          'data/insurers[_insurers list]', insurer.name);
    }
    _insurers.removeAt(index);
  }

  /// get Quantity of active contracts for all insurers combined
  /// @params Insurers insurers
  /// @return sum
  int quantityActiveContracts(Insurers insurers) {
    int sum = 0;
    for (var insurer in insurers.list) {
      sum += insurer.activeContracts.length;
    }
    return sum;
  }

  /// get Quantity of inactive contracts for all insurers combined
  /// @params Insurers insurers
  /// @return sum
  int quantityInactiveContracts(Insurers insurers) {
    int sum = 0;
    for (var insurer in insurers.list) {
      sum += insurer.inactiveContracts.length;
    }
    return sum;
  }

  /// Print average income for every insurer
  /// @params Insurer insurer
  void averageIncomePerInsurer(Insurer insurer) {
    var sum = 0.0;
    if (insurer.activeContracts.isNotEmpty) {
      for (var i = 0; i < insurer.activeContracts.length; i++) {
        sum += insurer.activeContracts[i].anualFee;
      }
    }
    print('Insurance: ${insurer.name}');
    print('Average income: ${sum / insurer.activeContracts.length}\n');
  }

  /// Print the average income for a type of contract
  /// @params Insurers insurers
  /// @params String type
  void averageIncomePerType(Insurers insurers, String type) {
    var sum = 0.0;
    var counter = 0;
    for (var insurer in insurers.list) {
      for (var contract in insurer.activeContracts) {
        if (contract.type == type) {
          sum += contract.anualFee;
          counter++;
        }
      }
    }
    print('Quantity of active contracts with type: $type => $counter');
    print('Average income: ${sum / counter}');
  }

  /// Income report grouped by Insurer
  /// Including total income for every insurer
  /// @params Insurers insurers

  void incomeReportPerInsurer(Insurers insurers) {
    List<double> totalIncomePerInsurer = List.filled(999, 0.0);
    List<String> insurersNames = List.filled(999, '');
    print('\x1b[1m-----------------------------------------------------------\n'
        '                 Income Report By Insurer\n'
        '-----------------------------------------------------------');
    print('Name\t       Type\t        Fee\n'
        '-----------------------------------------------------------\x1b[0m');
    for (var i = 0; i < insurers.list.length; i++) {
      for (var contract in insurers.list[i].activeContracts) {
        stdout.write('${insurers.list[i].name.padRight(10)}\t');
        stdout.write('${contract.type.padRight(10)}\t');
        stdout.write('${contract.anualFee.toStringAsFixed(2).padLeft(8)} €');
        totalIncomePerInsurer[i] += contract.anualFee;
        insurersNames[i] = insurers.list[i].name;
        print("");
      }
    }

    print('\x1b[1m-----------------------------------------------------------');
    for (var totalIncome in totalIncomePerInsurer) {
      if (totalIncome == 0.0) break;
      print(
          '${insurersNames[totalIncomePerInsurer.indexOf(totalIncome)]} has a total income of ${totalIncomePerInsurer[totalIncomePerInsurer.indexOf(totalIncome)]}');
    }

    print(
        '\x1b[1m------------------------End of report----------------------\x1b[0m');
  }

  // List every insurer
  void listInsurers() {
    print(
        '\x1b[1m---------------------------------------------------------------------\n'
        '                        Insurers List\n'
        '---------------------------------------------------------------------');
    print('Id\tName\t          Active Contracts\t  Inactive Contracts\n'
        '---------------------------------------------------------------------\x1b[0m');
    // ignore: avoid_function_literals_in_foreach_calls
    _insurers.forEach((i) {
      stdout.write('${i.id.toStringAsFixed(0).padRight(5)}\t');
      stdout.write('${i.name.padRight(22)}\t');
      stdout.write(
          '${i.activeContracts.length.toStringAsFixed(0).padRight(20).padLeft(10)}\t');
      stdout.write(
          '${i.inactiveContracts.length.toStringAsFixed(0).padRight(10)}\t');
      print("");
    });
    print(
        '\x1b[1m------------------------------End of List----------------------------\x1b[0m');
  }
}
