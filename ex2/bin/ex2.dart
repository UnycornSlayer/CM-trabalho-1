import 'dart:math';
import 'dart:io';

void main(List<String> args) {
  // Setting a random size for the array
  final int quantity = random(90, 150);
  List<int> numbers = generateNumbers(quantity), oddNumbers = [];

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
      case 1:
        print('Smaller: ${numbers[0]}\nBigger: ${numbers[quantity - 1]}');
        break;

      case 2:
        print('Range: ${numbers[quantity - 1] - numbers[0]}');
        break;

      case 3:
        List<int> oddNumbers = checkOddNumbers(numbers.reversed.toList());
        print('Odd numbers: $oddNumbers');
        break;
      case 4:
        print('Numbers: $numbers');
        break;
      case 5:
        exit(0);

      default:
        print('Invalid!');
        break;
    }
  }
}

List<int> checkOddNumbers(List<int> numbers) {
  List<int> oddNumbers = [];
  print(numbers.length);
  for (int i = 0; i < numbers.length; i++) {
    if (numbers[i].isOdd) oddNumbers.add(numbers[i]);
  }

  return oddNumbers;
}

List<int> generateNumbers(int quantity) {
  List<int> numbers = [];
  //fill the array with random numbers
  for (var i = 0; i < quantity; i++) {
    numbers.add(random(1, 1000));
  }

  return numbers;
}

// Function to return a random number between two numbers
// @params int min , int max
// @return random number
int random(int min, int max) {
  return min + Random().nextInt(max - min);
}
