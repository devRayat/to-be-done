import 'package:hive/hive.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  final int typeId = 62;

  @override
  Duration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Duration(milliseconds: fields[0] as int);
  }

  @override
  void write(BinaryWriter writer, Duration obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.inMilliseconds);
  }
}
