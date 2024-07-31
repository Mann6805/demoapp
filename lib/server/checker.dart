import 'package:shared_preferences/shared_preferences.dart';

class Checker {
  bool? isCustomer;
  String? customerid;
  String? vendorid;

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

  Future<void> loadCustomerStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isCustomer = prefs.getBool('isCustomer');
    customerid = prefs.getString('customerid');
    vendorid = prefs.getString('vendorid');
  }
}
