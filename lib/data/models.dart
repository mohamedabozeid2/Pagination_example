
class ApiModel{
  int? totalPassengers;
  int? totalPages;
  List<Passengers> passengers = [];

  // ApiModel({required this.passengers, required this.totalPages, required this.totalPassengers});

  ApiModel.fromJson(Map<String, dynamic> json){
    totalPassengers = json['totalPassengers'];
    totalPages = json['totalPages'];
    passengers = json['data'];
    json['data'].forEach((element){
      passengers.add(Passengers.fromJson(element));
    });
  }
}

class Passengers{
  String? id;
  String? name;
  int? trips;
  List<AirLine> airLine = [];
  int? v;

  // Passengers({required this.name, required this.id, required this.airLine, required this.trips, required this.v});

  Passengers.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    name = json['name'];
    trips = json['_trips'];
    json['airline'].forEach((element){
      airLine.add(AirLine.fromJson(element));
    });
    v = json['__v'];
  }
}

class AirLine{
  int? id;
  String? name;
  String? country;
  String? logo;
  String? slogan;
  String? head_quaters;
  String? website;
  String? established;

  AirLine.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    country = json['country'];
    logo = json['logo'];
    slogan = json['slogan'];
    head_quaters = json['head_quaters'];
    website = json['website'];
    established = json['established'];
  }
}