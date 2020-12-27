import 'dart:async';

StreamController<String> _controller = StreamController<String>.broadcast();
Stream<String> get out => _controller.stream;

void main() {
  out.listen((data) {
    print(data);
  });

  out.listen((data) {
    print(data.replaceAll('a', 'b'));
  });
  add();
}

void add() {
  _controller.sink.add('somedata');
}
