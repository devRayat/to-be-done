part of mocks;

final todoMocks = List.generate(6, (_) => Todo.demo(nanoid(6))).obs;
