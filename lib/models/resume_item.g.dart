// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResumeItemAdapter extends TypeAdapter<ResumeItem> {
  @override
  final int typeId = 0;

  @override
  ResumeItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResumeItem(
      title: fields[0] as String,
      description: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ResumeItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResumeItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
