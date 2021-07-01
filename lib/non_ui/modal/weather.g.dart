// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final int typeId = 0;

  @override
  Weather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weather(
      time: fields[0] as int?,
      temperature: fields[1] as double?,
      aTemperature: fields[2] as double?,
      summary: fields[3] as String?,
      icon: fields[4] as String?,
      dewPoint: fields[5] as double?,
      humidity: fields[6] as double?,
      pressure: fields[7] as double?,
      windSpeed: fields[8] as double?,
      windGust: fields[9] as double?,
      windBearing: fields[10] as double?,
      cloudCover: fields[11] as int?,
      visibility: fields[12] as double?,
      ozone: fields[13] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.temperature)
      ..writeByte(2)
      ..write(obj.aTemperature)
      ..writeByte(3)
      ..write(obj.summary)
      ..writeByte(4)
      ..write(obj.icon)
      ..writeByte(5)
      ..write(obj.dewPoint)
      ..writeByte(6)
      ..write(obj.humidity)
      ..writeByte(7)
      ..write(obj.pressure)
      ..writeByte(8)
      ..write(obj.windSpeed)
      ..writeByte(9)
      ..write(obj.windGust)
      ..writeByte(10)
      ..write(obj.windBearing)
      ..writeByte(11)
      ..write(obj.cloudCover)
      ..writeByte(12)
      ..write(obj.visibility)
      ..writeByte(13)
      ..write(obj.ozone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
