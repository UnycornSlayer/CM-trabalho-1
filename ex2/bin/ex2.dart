import 'dart:math';
import 'dart:io';

// Function to return a random number between two numbers
// @params int min , int max
// @return random number
int random(int min, int max) {
  return min + Random().nextInt(max - min);
}

void main(List<String> args) {
  bool flag = true;
  List<int> numbers = [], oddNumbers = [];
  int quantity = random(90, 151); // Setting a random size for the array
  //fill the array with random numbers
  for (var i = 0; i < quantity; i++) {
    numbers.add(Random().nextInt(1000));
  }

  print('\n\n\n\n\nRandom quantity if numbers: $quantity');
  // Basic switch case menu
  while (flag) {
    print('\nOptions: \n');
    print('1 - Smaller and Bigger number');
    print('2 - Range of the set');
    print('3 - Odd numbers in descending order');
    print('4 - See set');
    print('5 - Exit');
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
        for (int i = numbers.length - 1; i > 0; i--) {
          if (i.isOdd) oddNumbers.add(i);
        }
        print('Odd numbers: $oddNumbers');
        break;
      case 4:
        print('Numbers: $numbers');
        break;
      case 5:
        flag = false;
        break;

      default:
        print('Invalid!');
        break;
    }
  }
}
