class CustomerCreateModel {
    String name;
    String phone;
    String? email;
    String type;
    String? address;
    String? area;
    String? postCode;
    String? city;
    String? state;
    String accountName;
    String? accountNumber;
    String? routingNumber;
    String? swiftCode;

    CustomerCreateModel({
        required this.name,
        required this.phone,
        this.email,
        required this.type,
        this.address,
        this.area,
        this.postCode,
        this.city,
        this.state,
        required this.accountName,
        this.accountNumber,
        this.routingNumber,
        this.swiftCode,
    });

    factory CustomerCreateModel.fromJson(Map<String, dynamic> json) => CustomerCreateModel(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        type: json["type"],
        address: json["address"],
        area: json["area"],
        postCode: json["post_code"],
        city: json["city"],
        state: json["state"],
        accountName: json["account_name[]"],
        accountNumber: json["account_number[]"],
        routingNumber: json["routing_number[]"],
        swiftCode: json["swift_code[]"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "type": type,
        "address": address,
        "area": area,
        "post_code": postCode,
        "city": city,
        "state": state,
        "account_name[]": accountName,
        "account_number[]": accountNumber,
        "routing_number[]": routingNumber,
        "swift_code[]": swiftCode,
    };
}