// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Activity {
  final int id;
  final String name;
  final String img;
  Activity(
    this.id,
    this.name,
    this.img,
  );


  Activity copyWith({
    int? id,
    String? name,
    String? img,
  }) {
    return Activity(
      id ?? this.id,
      name ?? this.name,
      img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'img': img,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      map['id'] as int,
      map['name'] as String,
      map['img'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) => Activity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Activity(id: $id, name: $name, img: $img)';

  @override
  bool operator ==(covariant Activity other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.img == img;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ img.hashCode;
}
