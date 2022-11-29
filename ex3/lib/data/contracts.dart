import 'package:ex3/data/insurers.dart';

import '../exceptions/already_existing_item_exception.dart';
import '../exceptions/doesnt_exist_on_list_exception.dart';
import '../models/contract.dart';

class Contracts {
  final List<Contract> _contracts = [];

  List<Contract> get list => _contracts;

  void add(Contract contract) {
    if (_contracts.any((c) => c.id == contract.id)) {
      throw AlreadyExistingItemException(
          'data/students[_students list]', contract.id.toString());
    }
    _contracts.add(contract);
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
    // TODO: cant remove if has active contracts
    _contracts.removeAt(index);
  }

  void incomePerType(Contracts contracts) {
    // TODO: Se não houver contratos de um tipo, não mostrar nada relativo a esse tipo

    /**
     * Income Array:
     * positon [0] = type car
     * position [1] = type health
     * position [2] = type life
     */
    var totalIncomePerType = [0.0, 0.0, 0.0];
    print('------------Income report per Type------------');
    for (var contract in contracts.list) {
      if (contract.insurer.activeContracts.contains(contract)) {
        switch (contract.type) {
          case 'car':
            print('\n\x1b[1mType: car\x1b[0m');
            print(
                'Contract with ${contract.insurer.name}, Type: car, Fee: ${contract.anualFee}€.');
            totalIncomePerType[0] += contract.anualFee;
            break;
          case 'health':
            print('\n\x1b[1mType: health\x1b[0m');
            print(
                'Contract with ${contract.insurer.name}, Type: health, Fee: ${contract.anualFee}€.');
            totalIncomePerType[1] += contract.anualFee;
            break;
          case 'life':
            print('\n\x1b[1mType: life\x1b[0m');
            print(
                'Contract with ${contract.insurer.name}, Type: life, Fee: ${contract.anualFee}€.');
            totalIncomePerType[2] += contract.anualFee;
            break;
        }
      }
    }
    print((totalIncomePerType[0] > 0.0
            ? '\n\x1b[1mType car has a total income of: ${totalIncomePerType[0]}\x1b[0m'
            : '') +
        (totalIncomePerType[1] > 0.0
            ? '\n\x1b[1mType health has a total income of:${totalIncomePerType[1]}\x1b[0m'
            : '') +
        (totalIncomePerType[2] > 0.0
            ? '\n\x1b[1mType life has a total income of:${totalIncomePerType[2]}\x1b[0m'
            : ''));
    print('----------------End of report----------------');
  }
}
