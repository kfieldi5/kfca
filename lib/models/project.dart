class Project {
  const Project({
    required this.imagePath,
    required this.title,
    required this.desc,
    this.link = "",
    this.linkText = "",
  });

  final String imagePath;
  final String title;
  final String desc;
  final String link;
  final String linkText;
}
