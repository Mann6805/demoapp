import 'package:shared_preferences/shared_preferences.dart';

class Checker {
  bool? isCustomer;
  String? customerid;
  String? vendorid;
  String? address;

  // Method to set customer status and IDs
  void setCustomerStatus(bool isCustomer, String customerid, String vendorid) async {
    this.isCustomer = isCustomer;
    this.customerid = customerid;
    this.vendorid = vendorid;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCustomer', isCustomer);
    await prefs.setString('customerid', customerid);
    await prefs.setString('vendorid', vendorid);

    print("Status set to customer: $isCustomer");
    print("Customer ID: $customerid");
    print("Vendor ID: $vendorid");
  }

  // Method to load customer status and IDs
  Future<void> loadCustomerStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isCustomer = prefs.getBool('isCustomer');
    customerid = prefs.getString('customerid');
    vendorid = prefs.getString('vendorid');
    address = prefs.getString('address');
  }

  // Method to set address
  void setAddress(String address) async {
    this.address = address;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', address);

    print("Address set: $address");
  }

  Future<String?> getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('address');
  }

}
