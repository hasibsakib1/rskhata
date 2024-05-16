class BranchModel {
    int? id;
    String? name;

    BranchModel({
        this.id,
        this.name,
    });

    factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}