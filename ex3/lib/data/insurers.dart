import 'package:ex3/exceptions/cannot_delete_element_with_active_contracts.dart';
import 'package:ex3/models/contract.dart';

import '../exceptions/already_existing_item_exception.dart';
import '../exceptions/doesnt_exist_on_list_exception.dart';
import '../models/insurer.dart';

class Insurers {
  final List<Insurer> _insurers = [];

  List<Insurer> get list => _insurers;

  void add(Insurer insurer) {
    if (_insurers.any((i) => i.id == insurer.id)) {
      throw AlreadyExistingItemException(
          'data/students[_students list]', insurer.id.toString());
    }
    _insurers.add(insurer);
  }

  void update(Insurer insurer) {
    int index = _insurers.indexWhere((i) => i.id == insurer.id);

    if (index == -1) {
      throw DoesntExistOnListException(
          'data/students[_students list]', insurer.id.toString());
    }
    _insurers[index] = insurer;
  }

  void delete(Insurer insurer) {
    int index = _insurers.indexWhere((i) => i.id == insurer.id);
    //print(insurer.activeContracts);
    if (index == -1) {
      throw DoesntExistOnListException(
          'data/students[_students list]', insurer.id.toString());
    } else if (insurer.activeContracts.isNotEmpty) {
      throw CannotDeleteElementWithActiveContracts(
          'data/insurers[_insurers list]', insurer.name);
    }
    // TODO: cant remove if has active contracts
    _insurers.removeAt(index);
  }

  void addContract(Contract contract, Insurer insurer) {
    try {
      insurer.activeContracts.add(contract);
    } catch (e) {
      print(e);
    }
  }

  void inactiveContract(Contract contract, Insurer insurer) {
    try {
      insurer.inactiveContracts.add(contract);
    } catch (e) {
      print(e);
    }
  }

  // TODO: Melhorar esta função
  double averageIncomePerInsurer(Insurer insurer) {
    try {
      var sum = 0.0;
      if (insurer.activeContracts.isNotEmpty) {
        for (var i = 0; i < insurer.activeContracts.length; i++) {
          sum += insurer.activeContracts[i].anualFee;
          print(insurer.activeContracts[i].anualFee);
        }
        return sum / insurer.activeContracts.length;
      }
      return 0.0;
    } catch (e) {
      print(e);
      return 0.0;
    }
  }

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
}
