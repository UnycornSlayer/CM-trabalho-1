import '../exceptions/already_existing_item_exception.dart';
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
    }
    // TODO: cant remove if has active contracts
    _persons.removeAt(index);
  }
}
