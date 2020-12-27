Stream<int> getNumbers() async* {
  for (var i = 1; i <= 3; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
  }
}

Stream<int> getNumbersDuplicates() async* {
  for (var i = 1; i <= 3; i++) {
    yield i;
    yield i;
    await Future.delayed(Duration(seconds: 1));
  }
}

void expand() {
  getNumbers()
    .expand((data) => [data, data * 10, 123, 333])
    .listen((item) {
      print(item);
    });
}

void map() {
  // getNumbers()
  //   .map((i) => i * 10)
  //   .listen((item) {
  //     print(item);
  //   });

  getNumbers()
    .map((i) {
      if (i % 2 == 0) {
        return i * 2;
      } else {
        return i - 1;
      }
    })
     .listen((item) {
       print(item);
     });
}

void skip() {
  getNumbers().skip(100)
    .listen((item) {
      print(item);
    });
}

void skipWhile() {
  getNumbers().skipWhile((i) {
    return i < 10;
  })
    .listen((item) {
      print(item);
    });
}

void take() {
  getNumbers().take(2)
    .listen((data) {
      print(data);
    });
}

void takeWhile() {
  getNumbers()
    .takeWhile((item) => item < 3)
    .listen((data) {
      print(data);
    });
}

void where() {
  getNumbers()
    .where((item) => item % 2 == 0)
    .listen((data) {
      print(data);
    });
}

void distinct() {
  getNumbersDuplicates()
    .distinct()
    .listen((data) {
      print(data);
    });
}

void chaining() {
  getNumbersDuplicates()
    .distinct()
    .map((item) => item * 10)
    .where((item) => item != 20)
    .listen((data) {
      print(data);
    });
}

void main() {
  // expand();
  // map();
  // skip();
  // skipWhile();
  // take();
  // takeWhile();
  // where();
  // distinct();
  chaining();
}