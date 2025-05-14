class BusinessModel {
  String name;
  String industry;
  String type;
  String location;
  String currency;

  BusinessModel({
    required this.name,
    required this.industry,
    required this.type,
    required this.location,
    required this.currency,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'industry': industry,
      'type': type,
      'location': location,
      'currency': currency,
    };
  }

  factory BusinessModel.fromMap(Map<String, dynamic> map) {
    return BusinessModel(
      name: map['name'] ?? '',
      industry: map['industry'] ?? '',
      type: map['type'] ?? '',
      location: map['location'] ?? '',
      currency: map['currency'] ?? '',
    );
  }
}
