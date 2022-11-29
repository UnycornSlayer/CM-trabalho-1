import 'package:ex3/models/contract.dart';

import '../exceptions/already_existing_item_exception.dart';
import '../exceptions/doesnt_exist_on_list_exception.dart';
import '../models/insurer.dart';

class Insurers {
  final List<Insurer> _insurers = [];

  List<Insurer> get list => _insurers;

  void add(Insurer insurer) {
    if (_insurers.any((s) => s.id == insurer.id)) {
      throw AlreadyExistingItemException(
          'data/students[_students list]', insurer.id.toString());
    }
    _insurers.add(insurer);
  }

  void update(Insurer insurer) {
    int index = _insurers.indexWhere((s) => s.id == insurer.id);

    if (index == -1) {
      print(index);
      throw DoesntExistOnListException(
          'data/students[_students list]', insurer.id.toString());
    }
    _insurers[index] = insurer;
  }

  void delete(Insurer insurer) {
    int index = _insurers.indexWhere((s) => s.id == insurer.id);

    if (index == -1) {
      print(index);
      throw DoesntExistOnListException(
          'data/students[_students list]', insurer.id.toString());
    }
    // TODO: cant remove if has active contracts
    _insurers.removeAt(index);
  }

  int quantityActiveContracts(Insurer insurer) {
    return insurer.activeContracts.isNotEmpty
        ? insurer.activeContracts.length
        : 0;
  }

  int quantityInactiveContracts(Insurer insurer) {
    return insurer.inactiveContracts.isNotEmpty
        ? insurer.inactiveContracts.length
        : 0;
  }

  void addContract(Contract contract, Insurer insurer) {
    try {
      insurer.activeContracts.add(contract);
    } catch (e) {
      print(e);
    }
  }

  // TODO: Melhorar esta função
  double averageIncome(Insurer insurer) {
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
}
