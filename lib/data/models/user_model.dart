class UserModel {
  final String? name;
  final String? surname;
  final String? image;

  UserModel(this.name, this.surname, this.image);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json["name"], json["surname"], json["image"]);
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'surname': surname,
    'image': image
  };
}