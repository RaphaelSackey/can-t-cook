class Recipe {
  final String image;
  final String description;
  final String title;

  Recipe({required this.image, required this.description, required this.title});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      image: json['image'],
      description: json['recipe'],
      title: json['title'],
    );
  }
}
