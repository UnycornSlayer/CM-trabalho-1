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
    // TODO: cant remove if has active contracts
    _contracts.removeAt(index);
  }
}
