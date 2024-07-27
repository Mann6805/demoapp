// ignore_for_file: file_names, non_constant_identifier_names

class Vendorpost {

  String name = "";
  String mobile_no = "";
  String email = "";

  Vendorpost({
    required this.name,
    required this.mobile_no,
    required this.email
  });

  factory Vendorpost.fromJson(Map<String, dynamic> json) => Vendorpost(
    name: json["name"],
    mobile_no: json["mobile_no"], 
    email: json["email"]
  );

}