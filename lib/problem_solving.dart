
void main() {}

int trailingZeros(int n) {
  int count = 0;
  while ((n & 1) == 0 && n != 0) {
    count++;
    n >>= 1;
  }
  return count;
}

bool comp(List<int> a1, List<int> a2) {
  final List<int> a = a1.map((e) => e * e).toList();
  final firstList = sortedList(a);
  final secondList = sortedList(a2);
  return firstList.length == secondList.length &&
      firstList.toString() == secondList.toString();
}

List sortedList(List<int> a) {
  a.sort();
  return a;
}
// bool comp(List<int> a1, a2) {
//   if (a1 == null || a2 == null) {
//     return false;
//   }
/// dart:collection package
//   return const ListEquality().equals(a1.map((e) => e * e).toList()..sort(), a2..sort());
// }

List<int> partsSums(List<int> ls) {
  final List<int> newList = [];
  int sum = 0;
  for (var n in ls) {
    sum += n;
  }

  newList.add(sum);
  for (var n in ls) {
    sum -= n;
    newList.add(sum);
  }
  return ls.isEmpty ? [0] : newList;
}

// one of this jar need 30m to be ready and you have 35m to test all the jars
// how many friends you can invite to help you to test all the jars

int friends(int n) {
  int numberOfFriends = 0;
  while (n > 1) {
    n = (n / 2).ceil();
    numberOfFriends++;
  }
  return numberOfFriends == 0 ? 0 : numberOfFriends - 1;
}

bool isUpperCase(String str) => str == str.toUpperCase();

List<int> monkeyCount(int n) {
  final List<int> test = [];
  for (var i = 1; i <= n; i++) {
    test.add(i);
  }
  return test;
}

List<int> divisibleBy(List<int> nums, int divisor) {
  final List<int> dividedList = [];
  for (int i = 0; i < nums.length; i++) {
    if ((nums[i] % divisor) == 0) {
      dividedList.add(nums[i]);
    }
  }
  return dividedList;
}

List<String> fixTheMeerkat(List<String> arr) => arr.reversed.toList();

int getAverage(List<int> arr) {
  int largest = 0;
  int smallest = 0;
  for (var i = 0; i < arr.length; i++) {
    arr[i] >= largest ? largest = arr[i] : smallest = arr[i];
  }
  return (largest + smallest) ~/ 2;
}
