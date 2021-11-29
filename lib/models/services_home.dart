class ServicesHome {
  final String title;
  final String description;
  final String icon;

  ServicesHome(
    this.title,
    this.description,
    this.icon,
  );

  ServicesHome.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        icon = json['icon'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'icon': icon,
      };

  @override
  String toString() {
    return 'ServicesHome{title: $title, description: $description, icon: $icon}';
  }
}
