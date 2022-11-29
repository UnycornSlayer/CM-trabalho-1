import 'package:ex3/data/contracts.dart';
import 'package:ex3/data/insurers.dart';
import 'package:ex3/data/persons.dart';
import 'package:ex3/exceptions/already_existing_item_exception.dart';
import 'package:ex3/exceptions/cannot_delete_element_with_active_contracts.dart';
import 'package:ex3/exceptions/doesnt_exist_on_list_exception.dart';
import 'package:ex3/models/contract.dart';
import 'package:ex3/models/insurer.dart';
import 'package:ex3/models/person.dart';

/*
  ✔️ Não esqueça de garantir a integridade das referências
  (e.g. uma seguradora não pode ser removida se existirem apólices relacionadas).

  ✔️ quantidade de apólices ativas e inativas.

  ✔️ quantidade de apólices e valor médio segurado por seguradora (apenas apólices ativas).

  ✔️ quantidade de apólices e valor médio segurado por tipo de seguro (apenas apólices ativas); 

  ✔️ Relatório de apólices ativas por tipo de seguro e seguradora, que indique o valor de cada prémio.
  (no final do relatório deve surgir o somatório da coluna dos prémios das apólices).

  ✔️ Relatório de entidades (i.e. tomadores e segurados) com apólices ativas, que mostre a idade e a morada de cada um.

  ❌ Meter contratos como inativos
  
*/

void main(List<String> arguments) {
  Insurers insurers = Insurers();
  Contracts contracts = Contracts();
  Persons clients = Persons();

  try {
    clients.add(
      Person(0, 'Miguel', 22, 'Rua de baixo', []),
    );

    clients.add(
      Person(1, 'Pedro', 21, 'Rua de cima', []),
    );

    clients.add(
      Person(2, 'Telmo', 23, 'Rua da esquerda', []),
    );

    clients.add(
      Person(3, 'Paulo', 22, 'Rua da Direita', []),
    );

    insurers.add(
      Insurer(0, 'ok teleseguros', [], []),
    );
    insurers.add(
      Insurer(1, 'fidelidade', [], []),
    );
    insurers.add(
      Insurer(2, 'nmldmn', [], []),
    );

    contracts.add(
      Contract(0, 'health', DateTime(2023 - 5 - 15), 8000, clients.list[0].name,
          insurers.list[0], clients.list[0]),
    );
    contracts.add(
      Contract(1, 'car', DateTime(2024 - 1 - 1), 10000, 'BMW Series 1',
          insurers.list[1], clients.list[1]),
    );
    contracts.add(
      Contract(2, 'life', DateTime(2022 - 12 - 31), 12000, clients.list[0].name,
          insurers.list[2], clients.list[2]),
    );
    contracts.add(
      Contract(3, 'car', DateTime(2024 - 02 - 22), 11000, 'OPEL Corsa',
          insurers.list[2], clients.list[2]),
    );
  } on AlreadyExistingItemException catch (e, f) {
    print(e.errorMessage());
    print(f);
  } on DoesntExistOnListException catch (e, f) {
    print(e.errorMessage());
    print(f);
  } on CannotDeleteElementWithActiveContracts catch (e, f) {
    print(e.errorMessage());
    print(f);
  }

  // insurers.averageIncomePerType(insurers, 'car');
  // insurers.incomeReportPerInsurer(insurers);
  // contracts.incomePerType(contracts);
  clients.entityReport(clients);
}

void printLists(List list) {
  // TODO: Format to make it look like a table
  print('------- SUMMARY (finally block) -------');
  for (var s in list) {
    print(s);
  }
}
