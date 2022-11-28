void main(List<String> arguments) {
  List<int> nums = [];
  int sum = 0;

  // addind every prime number between 100 and 200 to the nums Array
  // and summing them to calculate the average after
  for (int i = 101; i < 200; i++) {
    //checks if is a prime number
    if (isPrime(i)) {
      nums.add(i);
      sum += i;
    }
  }

  // application prints
  printTotals(sum, nums.length);
}

// prints the totals
// @params int sum
// @params int numsLength
void printTotals(int sum, int numsLength) {
  print('------------------------------------------------------------------');
  print('The sum is: $sum');
  print('The average is: ${sum / numsLength}');
  print('------------------------------------------------------------------');
}

// function to check if number is prime
// @params int n
// @return boolean
bool isPrime(int n) {
  for (var i = 2; i <= n / i; ++i) {
    if (n % i == 0) return false;
  }
  return true;
}
