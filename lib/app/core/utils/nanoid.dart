part of utils;

final _random = Random();
const _letters =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

String nanoid([int size = 10]) {
  final id = List.filled(size, '').reduce((value, element) {
    final randomInt = _random.nextInt(_letters.length);
    value += _letters[randomInt];
    return value;
  });
  return id;
}
