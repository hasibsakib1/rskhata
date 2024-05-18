// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
    int status;
    String msg;
    String description;
    Customer customer;
    List<CustomerBankAccount> customerBankAccounts;

    CustomerModel({
        required this.status,
        required this.msg,
        required this.description,
        required this.customer,
        required this.customerBankAccounts,
    });

    factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        status: json["status"],
        msg: json["msg"],
        description: json["description"],
        customer: Customer.fromJson(json["customer"]),
        customerBankAccounts: List<CustomerBankAccount>.from(json["customer_bank_accounts"].map((x) => CustomerBankAccount.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "description": description,
        "customer": customer.toJson(),
        "customer_bank_accounts": List<dynamic>.from(customerBankAccounts.map((x) => x.toJson())),
    };
}

class Customer {
    int id;
    int companyId;
    int branchId;
    int userId;
    String name;
    String phone;
    String email;
    int type;
    String balance;
    dynamic reminderDate;
    dynamic image;
    String address;
    String area;
    String postCode;
    String city;
    String state;
    int status;
    int createdBy;
    DateTime createdAt;
    int updatedBy;
    DateTime updatedAt;
    int deleted;
    dynamic deletedBy;
    dynamic deletedAt;
    dynamic showImage;

    Customer({
        required this.id,
        required this.companyId,
        required this.branchId,
        required this.userId,
        required this.name,
        required this.phone,
        required this.email,
        required this.type,
        required this.balance,
        required this.reminderDate,
        required this.image,
        required this.address,
        required this.area,
        required this.postCode,
        required this.city,
        required this.state,
        required this.status,
        required this.createdBy,
        required this.createdAt,
        required this.updatedBy,
        required this.updatedAt,
        required this.deleted,
        required this.deletedBy,
        required this.deletedAt,
        required this.showImage,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        companyId: json["company_id"],
        branchId: json["branch_id"],
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        type: json["type"],
        balance: json["balance"],
        reminderDate: json["reminder_date"],
        image: json["image"],
        address: json["address"],
        area: json["area"],
        postCode: json["post_code"],
        city: json["city"],
        state: json["state"],
        status: json["status"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedBy: json["updated_by"],
        updatedAt: DateTime.parse(json["updated_at"]),
        deleted: json["deleted"],
        deletedBy: json["deleted_by"],
        deletedAt: json["deleted_at"],
        showImage: json["show_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "branch_id": branchId,
        "user_id": userId,
        "name": name,
        "phone": phone,
        "email": email,
        "type": type,
        "balance": balance,
        "reminder_date": reminderDate,
        "image": image,
        "address": address,
        "area": area,
        "post_code": postCode,
        "city": city,
        "state": state,
        "status": status,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt.toIso8601String(),
        "deleted": deleted,
        "deleted_by": deletedBy,
        "deleted_at": deletedAt,
        "show_image": showImage,
    };
}

class CustomerBankAccount {
    int id;
    int customerId;
    dynamic bankName;
    String accountName;
    String accountNumber;
    String routingNumber;
    String swiftCode;
    int status;
    int createdBy;
    DateTime createdAt;
    int updatedBy;
    DateTime updatedAt;
    int deleted;
    dynamic deletedBy;
    dynamic deletedAt;

    CustomerBankAccount({
        required this.id,
        required this.customerId,
        required this.bankName,
        required this.accountName,
        required this.accountNumber,
        required this.routingNumber,
        required this.swiftCode,
        required this.status,
        required this.createdBy,
        required this.createdAt,
        required this.updatedBy,
        required this.updatedAt,
        required this.deleted,
        required this.deletedBy,
        required this.deletedAt,
    });

    factory CustomerBankAccount.fromJson(Map<String, dynamic> json) => CustomerBankAccount(
        id: json["id"],
        customerId: json["customer_id"],
        bankName: json["bank_name"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        routingNumber: json["routing_number"],
        swiftCode: json["swift_code"],
        status: json["status"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedBy: json["updated_by"],
        updatedAt: DateTime.parse(json["updated_at"]),
        deleted: json["deleted"],
        deletedBy: json["deleted_by"],
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "bank_name": bankName,
        "account_name": accountName,
        "account_number": accountNumber,
        "routing_number": routingNumber,
        "swift_code": swiftCode,
        "status": status,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt.toIso8601String(),
        "deleted": deleted,
        "deleted_by": deletedBy,
        "deleted_at": deletedAt,
    };
}
