// @dart=2.9
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/MemberOrder/Services/MemberOrderingService.dart';

void main() async {
  String cardID = "";
  MemberOrderingService memberOrderingService =
      MemberOrderingService(WebAPI_Config.mainWebAPIURL, cardID);

  // var orders = memberOrderingService.getPaidOrders();

  // CheckoutOrder checkoutOrder = CheckoutOrder();
  // checkoutOrder.cardID = cardID;
  // checkoutOrder.orderID = 1;
  // memberOrderingService.checkOut(checkoutOrder);

  // memberOrderingService.postSelectedDigitalFile(cardID, "");
  var orders = memberOrderingService.getCompltedDownloadingOrders();
}
