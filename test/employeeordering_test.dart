// @dart=2.9
import 'package:nat/src/EmployeeOrder/Models/RequestOrderDetails.dart';
import 'package:nat/src/EmployeeOrder/Services/EmployeeOrderingService.dart';

void main() async {
  String mainWebAPIUrl = "";
  EmployeeOrderingService employeeOrderingService =
      EmployeeOrderingService(mainWebAPIUrl);

  RequestOrderDetails requestOrderDetails = RequestOrderDetails();
  requestOrderDetails.branchID = "";
  requestOrderDetails.pageNumber = 1;
  requestOrderDetails.maxRowPerPage = 5;

  var results = await employeeOrderingService
      .getConsideredOrderDetails(requestOrderDetails);
}
