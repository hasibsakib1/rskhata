class RegistrationSuccessModel {
    int id;
    String apiToken;
    String name;
    String email;
    String phone;
    dynamic image;
    dynamic imageFullPath;
    String businessName;
    String businessType;
    int businessTypeId;
    String branch;
    int companyId;
    int branchId;

    RegistrationSuccessModel({
        required this.id,
        required this.apiToken,
        required this.name,
        required this.email,
        required this.phone,
        required this.image,
        required this.imageFullPath,
        required this.businessName,
        required this.businessType,
        required this.businessTypeId,
        required this.branch,
        required this.companyId,
        required this.branchId,
    });

    factory RegistrationSuccessModel.fromJson(Map<String, dynamic> json) => RegistrationSuccessModel(
        id: json["id"],
        apiToken: json["api_token"],
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
        "api_token": apiToken,
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
