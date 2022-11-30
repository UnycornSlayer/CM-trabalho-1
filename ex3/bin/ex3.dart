import 'dart:io';

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

    while (true) {
      print('------------------------------------------------\n');
      print('           Surpresas existem!\n');
      print('------------------------------------------------\n');
      print(' 1 - Quantity of active and inactive contracts');
      print(' 2 - Average anual fee for active contracts per insurer');
      print(' 3 - Average anual fee for active contracts per type');
      print(' 4 - Client Management');
      print(' 5 - Insurer Management');
      print(' 6 - Contract Management');
      print(' 7 - Exit program');
      print('------------------------------------------------\n');
      int? op = int.parse(stdin.readLineSync()!);
      switch (op) {
        case 1:
          int numActive = insurers.quantityActiveContracts(insurers);
          int numInactive = insurers.quantityInactiveContracts(insurers);
          print('Number of active contracts: $numActive');
          print('Number of inactive contracts: $numInactive ');
          break;

        case 2:
          for (var insurer in insurers.list) {
            insurers.averageIncomePerInsurer(insurer);
          }
          break;

        case 3:
          List types = ['car', 'health', 'life'];
          for (var type in types) {
            insurers.averageIncomePerType(insurers, type);
          }
          break;

        case 4:
          clients = manageClients(clients);
          break;

        case 5:
          insurers = manageInsurers(insurers);
          break;

        case 6:
          contracts = manageContracts(contracts, insurers, clients);
          break;
        default:
          print('\n\n\nSee you soon!! :)');
          exit(5);
      }
    }
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
}

Persons manageClients(Persons clients) {
  while (true) {
    print('------------------------------------------------\n');
    print('           Client Management\n');
    print('------------------------------------------------\n');
    print(' 1 - Create new client');
    print(' 2 - Update existing client');
    print(' 3 - Remove existing client');
    print(' 4 - List every client');
    print(' 5 - See entities report');
    print(' 6 - Exit client management');
    print('------------------------------------------------\n');
    int? op = int.parse(stdin.readLineSync()!);
    switch (op) {
      case 1:
        print('Client name:');
        String name = stdin.readLineSync()!;
        print('Client age:');
        int age = int.parse(stdin.readLineSync()!);
        print('Client address:');
        String address = stdin.readLineSync()!;
        clients.add(Person((clients.list[clients.list.length - 1].id + 1), name,
            age, address, []));
        break;

      case 2:
        clients.listPersons();
        print('Type Id of the client to update: ');
        int id = int.parse(stdin.readLineSync()!);
        var index = clients.list.indexWhere((c) => c.id == id);
        print('Client name:');
        String name = stdin.readLineSync()!;
        print('Client age:');
        int age = int.parse(stdin.readLineSync()!);
        print('Client address:');
        String address = stdin.readLineSync()!;
        clients.update(Person(clients.list[index].id, name, age, address,
            clients.list[index].contracts));
        break;

      case 3:
        clients.listPersons();
        print('Type Id of the client to delete: ');
        int id = int.parse(stdin.readLineSync()!);
        var index = clients.list.indexWhere((c) => c.id == id);
        clients.delete(clients.list[index]);
        break;

      case 4:
        clients.listPersons();
        break;

      case 5:
        clients.entityReport(clients);
        break;
      default:
        return clients;
    }
  }
}

Insurers manageInsurers(Insurers insurers) {
  while (true) {
    print('------------------------------------------------\n');
    print('           Insurer Management\n');
    print('------------------------------------------------\n');
    print(' 1 - Create new insurer');
    print(' 2 - Update existing insurer');
    print(' 3 - Remove existing insurer');
    print(' 4 - List every insurer');
    print(' 5 - See Income report per insurer');
    print(' 6 - Exit insurer management');
    print('------------------------------------------------\n');
    int? op = int.parse(stdin.readLineSync()!);
    switch (op) {
      case 1:
        print('Insurer name:');
        String name = stdin.readLineSync()!;
        insurers.add(
          Insurer(
              (insurers.list[insurers.list.length - 1].id + 1), name, [], []),
        );
        break;

      case 2:
        insurers.listInsurers();
        print('Type Id of the insurer to update: ');
        int id = int.parse(stdin.readLineSync()!);
        var index = insurers.list.indexWhere((c) => c.id == id);
        print('Insurer name:');
        String name = stdin.readLineSync()!;
        insurers.update(
          Insurer(id, name, insurers.list[index].activeContracts,
              insurers.list[index].inactiveContracts),
        );
        break;

      case 3:
        insurers.listInsurers();
        print('Type Id of the insurer to delete: ');
        int id = int.parse(stdin.readLineSync()!);
        var index = insurers.list.indexWhere((i) => i.id == id);
        insurers.delete(insurers.list[index]);
        break;

      case 4:
        insurers.listInsurers();
        break;

      case 5:
        insurers.incomeReportPerInsurer(insurers);
        break;
      default:
        return insurers;
    }
  }
}

Contracts manageContracts(
    Contracts contracts, Insurers insurers, Persons persons) {
  while (true) {
    String type = '';
    print('------------------------------------------------\n');
    print('           Contracts Management\n');
    print('------------------------------------------------\n');
    print(' 1 - Create new contract');
    print(' 2 - Update existing contract');
    print(' 3 - Remove existing contract');
    print(' 4 - Make contract inactive');
    print(' 5 - See Income report per contract');
    print(' 6 - See list of contracts');
    print(' 7 - Exit insurer management');
    print('------------------------------------------------\n');
    int? op = int.parse(stdin.readLineSync()!);
    switch (op) {
      //create
      case 1:
        print('Type of contract:');
        print(' 1 - Car');
        print(' 2 - Health');
        print(' 3 - Life');
        int? op = int.parse(stdin.readLineSync()!);
        switch (op) {
          case 1:
            type = 'car';
            break;
          case 2:
            type = 'health';
            break;
          case 3:
            type = 'life';
            break;
        }

        print('Expiration date (yyyy-MM-dd): ');
        String date = stdin.readLineSync()!;

        print('Anual fee:');
        double fee = double.parse(stdin.readLineSync()!);

        print('What / who is being insured?');
        String insured = stdin.readLineSync()!;

        persons.listPersons();
        print('Type the ID of the client to associate:');
        int pID = int.parse(stdin.readLineSync()!);
        int pIndex = contracts.list.indexWhere((c) => c.id == pID);

        insurers.listInsurers();
        print('Type the ID of the insurer to associate:');
        int iID = int.parse(stdin.readLineSync()!);
        int iIndex = contracts.list.indexWhere((i) => i.id == iID);

        contracts.add(
          Contract(
              contracts.list[contracts.list.length - 1].id,
              type,
              DateTime.parse('$date 00:00:00.000'),
              fee,
              insured,
              insurers.list[iIndex],
              persons.list[pIndex]),
        );
        break;

      case 2:
        //update
        contracts.listContracts();
        print('Type Id of the contract to update: ');
        int id = int.parse(stdin.readLineSync()!);

        print('Type of contract:');
        print(' 1 - Car');
        print(' 2 - Health');
        print(' 3 - Life');
        int? op = int.parse(stdin.readLineSync()!);
        switch (op) {
          case 1:
            type = 'car';
            break;
          case 2:
            type = 'health';
            break;
          case 3:
            type = 'life';
            break;
        }

        print('Expiration date (yyyy-MM-dd): ');
        String date = stdin.readLineSync()!;

        print('Anual fee:');
        double fee = double.parse(stdin.readLineSync()!);

        print('What / who is being insured?');
        String insured = stdin.readLineSync()!;

        persons.listPersons();
        print('Type the ID of the client to associate:');
        int pID = int.parse(stdin.readLineSync()!);
        int pIndex = contracts.list.indexWhere((c) => c.id == pID);

        insurers.listInsurers();
        print('Type the ID of the insurer to associate:');
        int iID = int.parse(stdin.readLineSync()!);
        int iIndex = contracts.list.indexWhere((i) => i.id == iID);

        contracts.update(Contract(
          id,
          type,
          DateTime.parse('$date 00:00:00.000'),
          fee,
          insured,
          insurers.list[iIndex],
          persons.list[pIndex],
        ));
        break;

      case 3:
        //delete
        contracts.listContracts();
        print('Type Id of the contract to delete: ');
        int id = int.parse(stdin.readLineSync()!);
        var index = contracts.list.indexWhere((i) => i.id == id);
        contracts.delete(contracts.list[index]);
        break;

      case 4:
        contracts.listContracts();
        print('Type Id of the contract to make inactive: ');
        int id = int.parse(stdin.readLineSync()!);
        var index = contracts.list.indexWhere((i) => i.id == id);
        contracts.makeInactive(contracts.list[index]);
        break;

      case 5:
        // income per type report
        contracts.incomePerType(contracts);
        break;
      case 6:
        contracts.listContracts();
        break;
      default:
        return contracts;
    }
  }
}
