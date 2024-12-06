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

//  {
//     "id": 1,
//     "title": "Welcome to MyApp",
//     "subtitle": "Discover amazing features to make your life easier, save time, and stay organized like never before. MyApp brings innovation and simplicity to your fingertips.",
//     "image": "https://blogimage.vantagecircle.com/content/images/2020/08/Employee-Onboarding.png"
//   },