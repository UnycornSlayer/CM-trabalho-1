import '../exceptions/already_existing_item_exception.dart';
import '../exceptions/doesnt_exist_on_list_exception.dart';
import '../models/insurer.dart';

class Insurers {
  List<Insurer> _insurers = [];

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
}
