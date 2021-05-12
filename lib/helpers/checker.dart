import 'dart:math';

String validator({String input, int digit}) {
  Set s = {};
  for (int i = 0; i < input.length; i++) {
    s.add(input[i]);
  }
  if (input.isEmpty) {
    return "Please submit a number";
  } else if (!input.contains(RegExp(r'^[0-9]+$'))) {
    return "Please submit only numbers";
  } else if (input.length < digit) {
    return "Please submit $digit digits";
  } else if (s.length < input.length) {
    return "Please don't use a digit more than one";
  } else if (s.length > digit) {
    return "Please submit $digit digits";
  } else {
    return null;
  }
}

int placeCount({String input, String number}) {
  int cnt = 0;
  for (int i = 0; i < input.length; i++) {
    if (input.contains(number[i])) {
      cnt++;
    }
  }
  return cnt;
}

int orderCount({String input, String number}) {
  int cnt = 0;
  for (int i = 0; i < input.length; i++) {
    if (input[i] == number[i]) {
      cnt++;
    }
  }
  return cnt;
}

String guessNumber(int digit) {
  final Random random = Random();
  String theNumber = "";
  while (theNumber.length < digit) {
    String x = random.nextInt(10).toString();
    if (!theNumber.contains(x)) {
      theNumber = theNumber + x;
    }
  }
  print(theNumber);
  return theNumber;
}
