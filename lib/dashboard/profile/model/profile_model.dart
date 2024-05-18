class ProfileModel {
    int? id;
    String name;
    String? email;
    String? phone;
    dynamic image;
    dynamic imageFullPath;
    String? businessName;
    String? businessType;
    int businessTypeId;
    String? branch;
    int? companyId;
    int? branchId;

    ProfileModel({
        this.id,
        required this.name,
        this.email,
        this.phone,
        this.image,
        this.imageFullPath,
        this.businessName,
        required this.businessType,
        required this.businessTypeId,
        this.branch,
        this.companyId,
        this.branchId,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        imageFullPath: json["image_full_path"],
        businessName: json["business_name"],
        businessType: json["business_type"],
        businessTypeId: json["business_type_id"],
        branch: json["branch"],
        companyId: json["company_id"],
        branchId: json["branch_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "image_full_path": imageFullPath,
        "business_name": businessName,
        "business_type": businessType,
        "business_type_id": businessTypeId,
        "branch": branch,
        "company_id": companyId,
        "branch_id": branchId,
    };
}