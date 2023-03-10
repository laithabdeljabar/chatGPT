// ignore_for_file: constant_identifier_names

class Model {
  Model({
    required this.id,
    required this.created,
    required this.root,
  });

  String id;
  int created;
  String root;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["id"],
        created: json["created"],
        root: json["root"],
      );
}
