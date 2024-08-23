import 'package:shared_preferences/shared_preferences.dart';

class Checker {
  bool? isCustomer;
  String? customerid;
  String? vendorid;
  String? address;
  double? customerlat;
  double? customerlong;
  double? vendorlat;
  double? vendorlong;

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

  void setLocation(double latitutde, double longitude) async {
    this.customerlat = latitutde;
    this.customerlong = longitude;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('customerlat', customerlat!);
    await prefs.setDouble('customerlong', customerlong!);
    print("Address set: $address");
  }

  void vsetLocation(double latitutde, double longitude) async {
    this.vendorlat = latitutde;
    this.vendorlong = longitude;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('vendorlat', vendorlat!);
    await prefs.setDouble('vendorlong', vendorlong!);
  }

  Future<String?> getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('address');
  }

  Future<double?> getlat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('customerlat');
  }

  Future<double?> getlong() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('customerlong');
  }

  Future<double?> vgetlat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('vendorlat');
  }

  Future<double?> vgetlong() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('vendorlong');
  }

}
