import 'package:ex3/models/insurer.dart';
import 'package:ex3/models/person.dart';

class Contract {
  int id;
  DateTime expirationDate;
  double anualFee;
  Person taker; // person whos wants the insurance
  Insurer insurer; // company that issues the insurance
  String insured; // thing / who is insured , EX: Car in car insuranse
  String type; // car insurance or life insurance or etc...

  /// Class constructor
  Contract(this.id, this.type, this.expirationDate, this.anualFee, this.insured,
      this.insurer, this.taker);

  @override

  /// Class method toString

  String toString() => 'Contract between $insurer and $taker for $anualFee€';
}
