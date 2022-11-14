class TravelModel {
  String name;
  String destination;
  String dateTime;
  String require;
  String description;

  TravelModel({
    required this.name,
    required this.destination,
    required this.dateTime,
    required this.require,
    required this.description,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'destination': destination,
        'dateTime': dateTime,
        'require': require,
        'description': description,
      };

  factory TravelModel.fromMap(Map<String, dynamic> map) {
    return TravelModel(
      name: map['name'],
      destination: map['destination'],
      dateTime: map['dateTime'],
      require: map['require'],
      description: map['description'],
    );
  }

  @override
  String toString() {
    return 'name: $name  destination: $destination  dateTime: $dateTime  require: $require  description: $description  }';
  }
}
