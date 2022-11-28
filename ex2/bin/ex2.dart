import 'dart:math';
import 'dart:io';

void main(List<String> args) {
  // Setting a random size for the array
  final int quantity = random(90, 150);
  // generating numbers given a quantity
  List<int> numbers = generateNumbers(quantity);

  //prints the quantity of numbers
  print('\n\n\n\n\nRandom quantity if numbers: $quantity');
  // Basic switch case menu
  while (true) {
    print('------------------------------------------------------------------');
    print('Options: \n');
    print('1 - Smaller and Bigger number');
    print('2 - Range of the set');
    print('3 - Odd numbers in descending order');
    print('4 - See set');
    print('5 - Exit');
    print('------------------------------------------------------------------');
    int op = int.parse(stdin.readLineSync()!);
    //sort the array to make it easier getting smaller and bigger number
    //as well as the range of the set
    numbers.sort();

    switch (op) {
      // Prints smaller and bigger number
      case 1:
        print('Smaller: ${numbers[0]}\nBigger: ${numbers[quantity - 1]}');
        break;

      // Prints range of the set
      case 2:
        print('Range: ${numbers[quantity - 1] - numbers[0]}');
        break;

      // Prints odd numbers in descending order
      case 3:
        List<int> oddNumbers = checkOddNumbers(numbers);
        print('Odd numbers: $oddNumbers');
        break;

      // Prints the whole set
      case 4:
        print('Numbers: $numbers');
        break;
      case 5:
        exit(0);

      // User input is invalid
      default:
        print('Invalid!');
        break;
    }
  }
}

// Function to check and return all the odd numbers in a given set
// @params List<int> numbers
// @return list of numbers
List<int> checkOddNumbers(List<int> numbers) {
  List<int> oddNumbers = [];
  print(numbers.length);
  for (int i = numbers.length - 1; i > 0; i--) {
    if (i.isOdd) oddNumbers.add(numbers[i]);
  }

  return oddNumbers;
}

// Function to gerate numbers given a quantity
// @params int quantity
// @return list of numbers
List<int> generateNumbers(int quantity) {
  List<int> numbers = [];
  //fill the array with random numbers
  for (var i = 0; i < quantity; i++) {
    numbers.add(random(1, 1000));
  }

  return numbers;
}

// Function to return a random number between two numbers
// @params int min
// @params int max
// @return random number
int random(int min, int max) {
  return min + Random().nextInt(max - min);
}
