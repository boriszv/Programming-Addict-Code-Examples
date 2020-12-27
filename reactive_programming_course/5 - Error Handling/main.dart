Stream<int> getNumbersError() async* {
  for (var i = 1; i <= 3; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 3));
    if (i == 2) {
      throw Exception();
    }
  }
}

Stream<int> getNumbersTimeout() async* {
  for (var i = 1; i <= 3; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 3));
  }
}

void handleError() {
  getNumbersError()
    .handleError((error) {
      print(error);
    })
    .first;
}

void timeout() {
  getNumbersTimeout()
    .timeout(Duration(seconds: 4))
    .listen(print);
}

void main() {
  // handleError();
  timeout();
}