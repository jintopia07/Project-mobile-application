// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Authentication/Models/AuthenticatedUser.dart';
import 'package:nat/Config/UI_Config.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/Config/WebSite_Config.dart';
import 'package:nat/src/MemberOrder/Models/Order.dart';
import 'package:nat/src/MemberOrder/Models/OrderDetail.dart';
import 'package:nat/src/MemberOrder/Screens/detail_inbasketorder.dart';
import 'package:nat/src/MemberOrder/Services/MemberOrderingService.dart';
import 'package:nat/src/Authentication/Services/AuthenticationService.dart';

class InBasketOrder extends StatefulWidget {
  const InBasketOrder({Key key}) : super(key: key);

  @override
  _InBasketOrderState createState() => _InBasketOrderState();
}

class _InBasketOrderState extends State<InBasketOrder> {
  Order order = Order();
  List<Order> orders = List<Order>.empty();
  List<OrderDetail> orderDetails = List<OrderDetail>.empty();

  Widget _body = Center(child: const CircularProgressIndicator());

  AuthenticatedUser authenticatedUser;
  String username;
  MemberOrderingService memberOrderingService;

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  @override
  void initState() {
    loadOrder();
    super.initState();
  }

  void loadOrder() async {
//Get current member info.
    authenticatedUser = (await AuthenticationService.getAuthenticatedUser());
    username = authenticatedUser.username;
    //Create order service and load order.
    memberOrderingService =
        MemberOrderingService(WebAPI_Config.mainWebAPIURL, username);

    orders = await memberOrderingService.getDraftOrders();
    if (orders.isNotEmpty) {
      order = orders.first;
      orderDetails = order.orderDetails;
    }
    setState(() {
      _body = Scaffold(
        appBar: AppBar(
          title: const Text('รายการขอทำสำเนา'),
          backgroundColor: Colors.teal[600],
        ),
        body: Container(
          margin: const EdgeInsets.only(
              right: defaultPadding * 1,
              left: defaultPadding * 1,
              bottom: defaultPadding * 1.5),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "จำนวนเงินรวม ${order.summaryPrice} บาท",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: UI_Config.defaultPadding * 1)),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailInBasketOrder(),
                        ),
                      );
                    },
                    label: const Text('ยืนยันการทำรายการ' , style: TextStyle(fontSize: 13),),
                    backgroundColor: Colors.teal[600],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: orderDetails.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(
                          bottom: UI_Config.defaultPadding,
                          right: UI_Config.defaultPadding * 0.5,
                          left: UI_Config.defaultPadding * 0.5),
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: UI_Config.defaultPadding,
                                    top: UI_Config.defaultPadding * 1.5,
                                   ),
                                child: Text(
                                    orderDetails[index].digitalFile.branchName),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: UI_Config.defaultPadding / 2,
                                    vertical: UI_Config.defaultPadding),
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: FadeInImage(
                                    height: 50,
                                    width: 50,
                                    placeholder: const AssetImage(
                                        'assets/images/picempty.png'),
                                    image: NetworkImage(
                                      "${WebSite_Config.mainWebSiteURLWithSAndDigitalFileFolder}/${orderDetails[index].digitalFile.storedPathThumnail}",
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: UI_Config.defaultPadding,
                                    top: UI_Config.defaultPadding * 1.5,
                                    left: UI_Config.defaultPadding),
                                child: Text(orderDetails[index]
                                    .digitalFile
                                    .digitalFileID),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: UI_Config.defaultPadding,
                                    top: UI_Config.defaultPadding * 1.5,
                                  ),
                                  child: Text(orderDetails[index]
                                      .calculatedPrice
                                      .toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: UI_Config.defaultPadding,
                                      top: UI_Config.defaultPadding * 1.5,
                                      right: UI_Config.defaultPadding,
                                      left: UI_Config.defaultPadding),
                                  child: GestureDetector(
                                      child: const Icon(Icons.delete)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Center(
              //   child: Container(
              //     margin: const EdgeInsets.only(
              //         top: UI_Config.defaultPadding * 1.5,
              //         right: UI_Config.defaultPadding * 1,
              //         left: UI_Config.defaultPadding * 1,
              //         bottom: UI_Config.defaultPadding * 1.5),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Container(
              //           padding: const EdgeInsets.only(
              //               bottom: UI_Config.defaultPadding * 2,
              //               top: UI_Config.defaultPadding * 5,
              //               right: UI_Config.defaultPadding,
              //               left: UI_Config.defaultPadding),
              //           child: Column(
              //             children: [
              //               Text(
              //                 "จำนวนเงินรวม ${order.summaryPrice} บาท",
              //                 style: const TextStyle(
              //                     fontWeight: FontWeight.w700, fontSize: 14),
              //               ),
              //               Padding(
              //                   padding: const EdgeInsets.only(
              //                       top: UI_Config.defaultPadding * 1)),
              //               FloatingActionButton.extended(
              //                 onPressed: () {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                       builder: (context) =>
              //                           const DetailInBasketOrder(),
              //                     ),
              //                   );
              //                 },
              //                 label: const Text('ยืนยันการทำรายการ'),
              //                 backgroundColor: Colors.teal[600],
              //               ),
              //               const SizedBox(
              //                 height: UI_Config.defaultPadding * 1.5,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
    });
  }

  void onCheckout() {
    //Post to web api to confirm all selected order details.
  }
}
