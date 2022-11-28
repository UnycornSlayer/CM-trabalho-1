import 'package:ex3/models/insurer.dart';
import 'package:ex3/models/person.dart';

class Contract {
  DateTime expirationDate;
  double anualFee;
  Person taker;
  Insurer insurer;
  String insured;

  Contract(this.expirationDate, this.anualFee, this.insured, this.insurer,
      this.taker);

  @override
  String toString() =>
      'Contract of $taker about $insured at $insurer has an expiration date of $expirationDate and an anual fee of $anualFee €';
}
