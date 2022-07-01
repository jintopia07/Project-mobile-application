// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/UI_Config.dart';

import '../../../constants.dart';

class DetailsApprovalOrder extends StatefulWidget {
  const DetailsApprovalOrder({Key key}) : super(key: key);

  @override
  _DetailsWaitingForApprovalOrderState createState() =>
      _DetailsWaitingForApprovalOrderState();
}

class _DetailsWaitingForApprovalOrderState extends State<DetailsApprovalOrder> {
  final List<String> _dummy = List<String>.generate(2, (index) => "Row: $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดรายการอนุมัติเรียบร้อย'),
        backgroundColor: Colors.teal[600],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4,
                offset: Offset(4, 8), // Shadow position
              ),
            ],
          ),
          margin: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: defaultPadding * 1.5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: const Text(
                  'ข้อมูลดิจิทัลไฟล์ที่ขอทำสำเนา',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Divider(
                  color: Colors.grey,
                  height: 40,
                ),
              ),
              _imageSectionCard(),
              const SizedBox(
                height: defaultPadding,
              ),
              _headerSectionCard(),
              const SizedBox(height: defaultPadding * 1.5),
              Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: const Text(
                  'ผลการพิจารณา',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Divider(
                  color: Colors.grey,
                  height: 40,
                ),
              ),
              _resonSectionCard(),
              const SizedBox(height: defaultPadding * 1.5),
              Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: const Text(
                  'รายละเอียดผู้ขอทำสำเนา',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Divider(
                  color: Colors.grey,
                  height: 40,
                ),
              ),
              _copySectionCard(),
              const SizedBox(height: defaultPadding * 1.5),
              Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: const Text(
                  'เกี่ยวกับการขอทำสำเนา',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Divider(
                  color: Colors.grey,
                  height: 40,
                ),
              ),
              _countSectionCard(),
              const SizedBox(height: defaultPadding),
              backSectionCard(),
              const SizedBox(
                height: defaultPadding * 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageSectionCard() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: UI_Config.defaultPadding / 2,
        ),
        child: Column(
          children: <Widget>[
            // Container(
            //   height: 50,
            //   width: 50,
            //   child: FadeInImage(
            //     height: 50,
            //     width: 50,
            //     placeholder: AssetImage('assets/images/picempty.png'),
            //     image: NetworkImage(
            //       WebSite_Config.mainWebSiteURLWithSAndDigitalFileFolder +
            //           "/" +
            //           orderDetails[index].digitalFile.storedPathThumnail,
            //     ),
            //   ),
            // ),

            Image.asset(
              "assets/images/NATPratum.png",
              width: double.infinity,
              height: 300,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
          ],
        ),
      );

  Widget _headerSectionCard() => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    "รหัสเอกสาร :",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: const Flexible(child: Text("10M/11")),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    "ชื่อไฟล์ดิจิทัล :",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: const Flexible(child: Text("10M00011.jpg")),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    "ชื่อเรื่อง :",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: const Flexible(child: Text("ภาพจากฟิล์มกระจก")),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding * 0.5,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Text(
                      "รายละเอียด :",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: defaultPadding * 0.5, left: defaultPadding),
                    child: const Text(
                        "สมเด็จพระเจ้าบรมวงศ์เธอ กรมพระยาดำรงราชานุภาพ และหม่อมเจ้าจุลดิศ ดิศกุล"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: defaultPadding * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    "ระยะเวลา :",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: const Flexible(child: Text("ม.ท")),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    "แหล่งที่มาเอกสาร :",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: const Flexible(child: Text("สำนักหอจดหมายเหตุแห่งชาติ")),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    "หน่วยงาน :",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: const Flexible(child: Text("สำนักหอจดหมายเหตุแห่งชาติ")),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _resonSectionCard() => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(),
              child: Text(
                "ผลการพิจารณา :",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Flexible(
                  child: Text(
                "อนุมัติ",
                style: TextStyle(color: Colors.green[700]),
              )),
            ),
          ],
        ),
      );

  Widget _copySectionCard() => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    "ชื่อ-นามสกุล :",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: defaultPadding),
                  child: const Text("นางสาว เสาวนีย์ ปราบหงษ์"),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    "เลขที่บัตรประจำตัว :",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: defaultPadding),
                  child: const Text("1540600056884"),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    "สัญชาติ :",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: defaultPadding),
                  child: const Text("ไทย"),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    "เชื้อชาติ :",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: defaultPadding),
                  child: const Text("ไทย"),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    "ระดับการศึกษา :",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: defaultPadding),
                  child: const Text("ปริญญาโท"),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    "สาขาวิชา :",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: defaultPadding),
                  child: const Text("ประวัติศาสตร์"),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _countSectionCard() => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(),
                child: Text(
                  "เหตุผลในการขอทำสำเนา :",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: const Text("ประกอบรายงาน"),
              ),
            ),
          ],
        ),
      );

  Widget backSectionCard() => Center(
        child: Container(
          height: 50,
          margin: const EdgeInsets.all(defaultPadding),
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding * 4.3,
          ),
          child: Column(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.teal[800]),
                  textStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.white)),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 1)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        color: Colors.teal[800],
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2),
                        child: const Text(
                          'ย้อนกลับ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
