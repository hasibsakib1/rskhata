class CustomerListModel {
    int id;
    String name;
    String phone;
    String balance;

    CustomerListModel({
        required this.id,
        required this.name,
        required this.phone,
        required this.balance,
    });

    factory CustomerListModel.fromJson(Map<String, dynamic> json) => CustomerListModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "balance": balance,
    };
}