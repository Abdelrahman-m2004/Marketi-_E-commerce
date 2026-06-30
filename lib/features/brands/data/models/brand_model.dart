import 'package:marketi/features/brands/domain/entities/brand_entity.dart';

class BrandModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? image;
  final String? description;
  final bool? isActive;
  final int? productsCount;

  const BrandModel({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.description,
    this.isActive,
    this.productsCount,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['logo'] as String?,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool?,
      productsCount: json['products_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'logo': image,
      'description': description,
      'is_active': isActive,
      'products_count': productsCount,
    };
  }

  BrandEntity toEntity() {
    return BrandEntity(
      id: id ?? 0,
      name: name ?? '',
      slug: slug ?? '',
      image: image ?? '',
      description: description,
      isActive: isActive ?? true,
      productsCount: productsCount ?? 0,
    );
  }
}
