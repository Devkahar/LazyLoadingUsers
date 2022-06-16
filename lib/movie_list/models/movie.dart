class Movie{
  final int id;
  final String picture;

  String get thumbnail => picture;

  const Movie({
    required this.id,
    required this.picture,
  });
  factory Movie.fromJson(Map<String, dynamic> json) {
    const String dummyUrl = 'https://www.stockunlimited.com/vector-illustration/cinema-background-with-movie-objects_1823381.html';
    const String baseImageUrl = 'https://image.tmdb.org/t/p/original';
    return Movie(
      id: json['id'],
      picture: json['poster_path']!=null?'$baseImageUrl${json['poster_path']}':dummyUrl,
    );
  }
}