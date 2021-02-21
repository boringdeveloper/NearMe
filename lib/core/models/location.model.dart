class Location {
  int id;
  String name;
  double lat;
  double long;

  Location({
    this.id,
    this.name,
    this.lat,
    this.long,
  });

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['long'] = this.long;

    return data;
  }
}
