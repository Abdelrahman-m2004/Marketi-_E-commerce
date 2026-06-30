class BrandEntity {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String? description;
  final bool isActive;
  final int productsCount;

  const BrandEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    this.description,
    required this.isActive,
    required this.productsCount,
  });
}
