class Restaurant {
  final String name;
  final String place;
  final int totalRatingScore;
  final int numberOfRatings;
  final String imageUrl;

  Restaurant({
    this.name,
    this.place,
    this.totalRatingScore,
    this.numberOfRatings,
    this.imageUrl,
  });

  factory Restaurant.fromJson(Map<String, dynamic> map) {
    return Restaurant(
      name: map['name'],
      place: map['place'],
      totalRatingScore: map['totalRatingScore'],
      numberOfRatings: map['numberOfRatings'],
      imageUrl: map['imageUrl'],
    );
  }
}
