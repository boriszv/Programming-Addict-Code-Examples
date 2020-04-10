Stream<int> getNumbers() async* {
  for (var i = 1; i <= 3; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
  }
}

Stream<int> getNumbersException() async* {
  for (var i = 1; i <= 3; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
    if (i == 2) {
      throw Exception();
    }
  }
}

void listen() async {
  /*getNumbers().listen((data) {
    print(data);
  });*/

  /*getNumbersException()
    .listen((data) {
      print(data);
    })
    .onError((error) {
      print('an error occured');
    });*/

  /*var sum = 0;
  getNumbers()
    .listen((data) {
      sum += data;
    })
    .onDone(() {
      print(sum);
    });*/
}

void awaitFor() async {
  var sum = 0;
  await for (var number in getNumbers()) {
    sum += number;
    print(number);
  }
  print(sum);
}

void isEmpty() async {
  if (await getNumbers().isEmpty) {
    print('stream is empty');
  } else {
    print('stream is not empty');
  }
}

void first() async {
  print(await getNumbers().first);
}

void last() async {
  print(await getNumbers().last);
}

void length() async {
  print(await getNumbers().length);
}

void single() async {
  print(await getNumbers().single);
}

void any() async {
  if (await getNumbers().any((int i) => i < 1)) {
    print('there is a number that is less than 1');
  } else {
    print('there is not a number that is less than 1');
  }
}

void contains() async {
  if (await getNumbers().contains(7)) {
    print('there is a number equal to 7');
  } else {
    print('there is not a number equal to 7');
  }
}

void elementAt() async {
  print(await getNumbers().elementAt(10));
}

void firstWhere() async {
  print(await getNumbers().firstWhere((i) => i > 12));
}

void join() async {
  print(await getNumbers().join(', '));
}

void lastWhere() async {
  print(await getNumbers().lastWhere((i) => i > 1));
}

void singleWhere() async {
  print(await getNumbers().singleWhere((i) => i <= 0));
}

void main() async {
  // listen();
  // awaitFor();
  //isEmpty();
  //first();
  //last();
  //length();
  // single();
  //any();
  //contains();
  //elementAt();
  //firstWhere();
  //join();
  // lastWhere();
  singleWhere();
}