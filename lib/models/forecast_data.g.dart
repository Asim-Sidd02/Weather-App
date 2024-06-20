// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForecastDataAdapter extends TypeAdapter<ForecastData> {
  @override
  final int typeId = 1;

  @override
  ForecastData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForecastData(
      date: fields[0] as String,
      temperature: fields[1] as double,
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ForecastData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.temperature)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
