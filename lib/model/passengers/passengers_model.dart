class PassengersModel {
  final int? totalPassengers;
  final int? totalPages;
  final List<PassengerData>? data;

  PassengersModel({
    this.totalPassengers,
    this.totalPages,
    this.data,
  });

  factory PassengersModel.fromJson(Map<String, dynamic> json) =>
      PassengersModel(
        totalPassengers: json["totalPassengers"],
        totalPages: json["totalPages"],
        data: List<PassengerData>.from(
            json["data"].map((x) => PassengerData.fromJson(x))),
      );
}

class PassengerData {
  final String? id;
  final String? name;
  final int? trips;
  final List<Airline>? airline;

  PassengerData({
    this.id,
    this.name,
    this.trips,
    this.airline,
  });

  factory PassengerData.fromJson(Map<String, dynamic> json) => PassengerData(
        id: json["_id"],
        name: json["name"],
        trips: json["trips"],
        airline:
            List<Airline>.from(json["airline"].map((x) => Airline.fromJson(x))),
      );
}

class Airline {
  final String? id;
  final int? airlineId;
  final String? name;
  final String? country;
  final String? logo;
  final String? slogan;
  final String? headQuaters;
  final String? website;
  final String? established;

  Airline({
    this.id,
    this.airlineId,
    this.name,
    this.country,
    this.logo,
    this.slogan,
    this.headQuaters,
    this.website,
    this.established,
  });

  factory Airline.fromJson(Map<String, dynamic> json) => Airline(
        id: json["_id"],
        airlineId: json["id"],
        name: json["name"],
        country: json["country"],
        logo: json["logo"],
        slogan: json["slogan"],
        headQuaters: json["head_quaters"],
        website: json["website"],
        established: json["established"],
      );
}
