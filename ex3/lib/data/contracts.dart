import 'dart:io';
import '../exceptions/already_existing_item_exception.dart';
import '../exceptions/doesnt_exist_on_list_exception.dart';
import '../models/contract.dart';

class Contracts {
  final List<Contract> _contracts = [];
  final List<Contract> _inactiveContracts = [];

  List<Contract> get list => _contracts;

  void add(Contract contract) {
    if (_contracts.any((c) => c.id == contract.id)) {
      throw AlreadyExistingItemException(
          'data/students[_students list]', contract.id.toString());
    }
    _contracts.add(contract);
    contract.insurer.activeContracts.add(contract);
    contract.taker.contracts.add(contract);
  }

  void update(Contract contract) {
    int index = _contracts.indexWhere((c) => c.id == contract.id);

    if (index == -1) {
      print(index);
      throw DoesntExistOnListException(
          'data/students[_students list]', contract.id.toString());
    }
    _contracts[index] = contract;
  }

  void delete(Contract contract) {
    int index = _contracts.indexWhere((c) => c.id == contract.id);

    if (index == -1) {
      print(index);
      throw DoesntExistOnListException(
          'data/students[_students list]', contract.id.toString());
    }
    _contracts.removeAt(index);
  }

  void makeInactive(Contract contract) {
    int index = _contracts.indexWhere((c) => c.id == contract.id);

    if (index == -1) {
      print(index);
      throw DoesntExistOnListException(
          'data/students[_students list]', contract.id.toString());
    }
    _contracts.removeAt(index);
    _inactiveContracts.add(contract);
    contract.insurer.inactiveContracts.add(contract);
    contract.taker.contracts.removeAt(index);
  }

  void incomePerType(Contracts contracts) {
    /**
     * Income Array:
     * positon [0] = type car
     * position [1] = type health
     * position [2] = type life
     */
    var totalIncomePerType = [0.0, 0.0, 0.0];
    var carContracts = [];
    var healthContracts = [];
    var lifeContracts = [];
    for (var contract in contracts.list) {
      if (contract.insurer.activeContracts.contains(contract)) {
        switch (contract.type) {
          case 'car':
            carContracts.add(contract);
            totalIncomePerType[0] += contract.anualFee;
            break;
          case 'health':
            healthContracts.add(contract);
            totalIncomePerType[1] += contract.anualFee;
            break;
          case 'life':
            lifeContracts.add(contract);
            totalIncomePerType[2] += contract.anualFee;
            break;
        }
      }
    }

    var everyType = [...carContracts, ...lifeContracts, ...healthContracts];

    print('\x1b[1m-----------------------------------------------------------\n'
        '                 Income Report By Type\n'
        '-----------------------------------------------------------');
    print('Name\t       Type\t        Fee\n'
        '-----------------------------------------------------------\x1b[0m');
    for (var contract in everyType) {
      stdout.write('${contract.insurer.name.padRight(10)}\t');
      stdout.write('${contract.type.padRight(10)}\t');
      stdout.write('${contract.anualFee.toStringAsFixed(2).padLeft(8)} €');
      print("");
    }
    print('\x1b[1m-----------------------------------------------------------');
    print((totalIncomePerType[0] > 0.0
            ? 'Type car has a total income of: ${totalIncomePerType[0]}'
            : '') +
        (totalIncomePerType[1] > 0.0
            ? '\nType health has a total income of:${totalIncomePerType[1]}'
            : '') +
        (totalIncomePerType[2] > 0.0
            ? '\nType life has a total income of:${totalIncomePerType[2]}'
            : ''));
    print('\x1b[1m----------------End of report----------------\x1b[0m');
  }

  void listContracts() {
    print(
        '\x1b[1m---------------------------------------------------------------------------\n'
        '                              Contracts List\n'
        '---------------------------------------------------------------------------');
    print('Id\tTaker Name\tInsurer Name\t Insured\t Type\t Anual Fee\n'
        '---------------------------------------------------------------------------\x1b[0m');
    // ignore: avoid_function_literals_in_foreach_calls
    _contracts.forEach((c) {
      stdout.write('${c.id.toStringAsFixed(0).padRight(7)}\t');
      stdout.write('${c.taker.name.padRight(8)}\t');
      stdout.write('${c.insurer.name.padRight(15)}\t');
      stdout.write('${c.insured.padRight(10).padLeft(7)}\t');
      stdout.write('${c.type.padRight(7)}\t');
      stdout.write('${c.anualFee.toStringAsFixed(0).padLeft(7)}\t');
      print("");
    });
    print(
        '\x1b[1m---------------------------------End of List-------------------------------\x1b[0m');
  }
}
