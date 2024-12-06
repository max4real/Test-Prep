class OnbordingModel {
  String id;
  String title;
  String subtitle;
  String image;

  OnbordingModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  factory OnbordingModel.fromAPI({required Map<String, dynamic> data}) {
    return OnbordingModel(
      id: data["id"].toString(),
      title: data["title"].toString(),
      subtitle: data["subtitle"].toString(),
      image: data["image"].toString(),
    );
  }
}
