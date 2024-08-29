class FeaturedCardData {
  final String icon;
  final String colour;
  final DateTime dateCreated;
  final String name;
  final double value;

  FeaturedCardData({
    this.icon = "",
    this.colour = "",
    required this.dateCreated,
    required this.value,
    required this.name,
  });
}
