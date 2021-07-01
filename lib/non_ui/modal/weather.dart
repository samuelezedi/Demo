import 'package:hive/hive.dart';

part 'weather.g.dart';

@HiveType(typeId: 0)
class Weather extends HiveObject {
  @HiveField(0)
  int? time;

  @HiveField(1)
  double? temperature;

  @HiveField(2)
  double? aTemperature;

  @HiveField(3)
  String? summary;

  @HiveField(4)
  String? icon;

  @HiveField(5)
  double? dewPoint;

  @HiveField(6)
  double? humidity;

  @HiveField(7)
  double? pressure;

  @HiveField(8)
  double? windSpeed;

  @HiveField(9)
  double? windGust;

  @HiveField(10)
  double? windBearing;

  @HiveField(11)
  int? cloudCover;

  @HiveField(12)
  double? visibility;

  @HiveField(13)
  double? ozone;

  Weather(
      {this.time,
      this.temperature,
      this.aTemperature,
      this.summary,
      this.icon,
      this.dewPoint,
      this.humidity,
      this.pressure,
      this.windSpeed,
      this.windGust,
      this.windBearing,
      this.cloudCover,
      this.visibility,
      this.ozone});
}
