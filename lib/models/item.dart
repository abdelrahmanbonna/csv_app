import 'dart:convert';

class Item {
  String id;
  String name;
  String area;
  String quantity;
  String brand;
  Item({
    required this.id,
    required this.name,
    required this.area,
    required this.quantity,
    required this.brand,
  });

  factory Item.empty() {
    return Item(
      id: '',
      name: '',
      area: '',
      brand: '',
      quantity: '',
    );
  }

  Item copyWith({
    String? id,
    String? name,
    String? area,
    String? quantity,
    String? brand,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      area: area ?? this.area,
      quantity: quantity ?? this.quantity,
      brand: brand ?? this.brand,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'area': area,
      'quantity': quantity,
      'brand': brand,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as String,
      name: map['name'] as String,
      area: map['area'] as String,
      quantity: map['quantity'] as String,
      brand: map['brand'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(id: $id, name: $name, area: $area, quantity: $quantity, brand: $brand)';
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.area == area &&
      other.quantity == quantity &&
      other.brand == brand;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      area.hashCode ^
      quantity.hashCode ^
      brand.hashCode;
  }
}
