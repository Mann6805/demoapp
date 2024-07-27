// ignore_for_file: file_names, non_constant_identifier_names

class Customerpost {

  String name = "";
  String mobile_no = "";
  String email = "";

  Customerpost({
    required this.name,
    required this.mobile_no,
    required this.email
  });

  factory Customerpost.fromJson(Map<String, dynamic> json) => Customerpost(
    name: json["name"],
    mobile_no: json["mobile_no"], 
    email: json["email"]
  );

}