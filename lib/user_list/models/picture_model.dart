class Picture {
  final String large;

  const Picture(this.large);

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    json['large'],
  );
}