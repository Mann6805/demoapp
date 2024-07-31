class Checker {
  bool? isCustomer;
  String? customerid;
  String? vendorid;

  void setCustomerStatus(bool isCustomer, String customerid, String vendorid) {
    this.isCustomer = isCustomer;
    this.customerid = customerid;
    this.vendorid = vendorid;
    print("Status set to customer: $isCustomer");
  }
}