// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Location {
  int id;
  String name;
  Location(
    this.id,
    this.name,
  );

  Location copyWith({
    int? id,
    String? name,
  }) {
    return Location(
      id ?? this.id,
      name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      map['id'] as int,
      map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) => Location.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Location(id: $id, name: $name)';

  @override
  bool operator ==(covariant Location other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
