class WeatherForecastResponseModel {
  WeatherForecastResponseModel({
    this.cod,
    this.message,
    this.cnt,
    this.data,
    this.city,
  });

  String? cod;
  int? message;
  int? cnt;
  List<WeatherResponseModel?>? data;
  City? city;

  factory WeatherForecastResponseModel.fromJson(Map<String, dynamic> json) =>
      WeatherForecastResponseModel(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        data: json["list"] == null
            ? []
            : List<WeatherResponseModel?>.from(
                json["list"]!.map((x) => WeatherResponseModel.fromJson(x))),
        city: City.fromJson(json["city"]),
      );
}

class City {
  City({
    this.name,
    this.country,
  });

  String? name;
  String? country;

  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json["name"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
      };
}

class WeatherResponseModel {
  WeatherResponseModel({this.weather, this.main, this.name, this.dtx});

  List<Weather?>? weather;
  Main? main;
  String? name;
  DateTime? dtx;

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) =>
      WeatherResponseModel(
          weather: json["weather"] == null
              ? []
              : List<Weather?>.from(
                  json["weather"]!.map((x) => Weather.fromJson(x))),
          main: Main.fromJson(json["main"]),
          name: json["name"],
          dtx: json["dt_txt"] == null ? null : DateTime.parse(json["dt_txt"]));
}

class Main {
  Main({
    this.temp,
    this.tempMin,
    this.tempMax,
  });

  double? temp;
  double? tempMin;
  double? tempMax;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
      );
}

class Weather {
  Weather({
    this.main,
    this.icon,
  });

  String? main;
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        main: json["main"],
        icon: json["icon"],
      );
}
