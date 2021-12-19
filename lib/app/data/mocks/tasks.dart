part of mocks;

final taskMocks = List.generate(6, (_) => Task.demo(nanoid(7))).obs;
