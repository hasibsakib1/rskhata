class BusinessTypeModel {
    int id;
    String name;
    String slug;

    BusinessTypeModel({
        required this.id,
        required this.name,
        required this.slug,
    });

    factory BusinessTypeModel.fromJson(Map<String, dynamic> json) => BusinessTypeModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
    };
}