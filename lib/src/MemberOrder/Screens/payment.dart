// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Payment extends StatefulWidget {
  const Payment({Key key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool visibilityCopy = false;
  bool visibilityGetcopy = false;
  bool visibilityPay = false;
  bool visibilityDoc = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "copy") {
        visibilityCopy = visibility;
      }
      if (field == "getcopy") {
        visibilityGetcopy = visibility;
      }
      if (field == "pay") {
        visibilityPay = visibility;
      }
      if (field == "doc") {
        visibilityDoc = visibility;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: Text( AppLocalizations.of(context).titlepayment,),
          backgroundColor: Colors.teal[600],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 40),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
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
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              visibilityCopy = !visibilityCopy;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: const Text(
                                  "การขอทำสำเนาเอกสารจดหมายเหตุ",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    visibilityCopy
                        ? Center(
                            child: Container(
                              padding: const EdgeInsets.only(top: defaultPadding * 1),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: defaultPadding,
                                    bottom: defaultPadding * 1,
                                    right: defaultPadding),
                                child: const Text(
                                  'เมื่อผู้ค้นคว้าสั่งขอทำสำเนาเอกสารจากระบบและชำระเงินแล้ว ผู้ค้นคว้าจะได้รับอีเมล์เพื่อยืนยันการสั่งทำสำเนาเอกสารพร้อมรายละเอียดการรับเอกสารที่สั่งทำสำเนา อีเมล์ที่ส่งจะเป็นข้อมูลที่ผู้ค้นคว้าระบุ ขั้นตอนการสมัครสมาชิก',
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
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
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              visibilityGetcopy = !visibilityGetcopy;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: const Text(
                                  "เงื่อนไขการขอทำสำเนาเอกสารจดหมายเหตุ",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    visibilityGetcopy
                        ? Container(
                            padding: const EdgeInsets.only(
                                left: defaultPadding,
                                bottom: defaultPadding * 1,
                                right: defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                SizedBox(height: defaultPadding),
                                Text(
                                  "   สำนักหอจดหมายเหตุแห่งชาติ กำหนดให้มีการขอทำสำเนาเอกสารจากระบบสืบค้นเอกสารจดหมายเหตุ ผ่านรูปแบบออนไลน์ได้แล้ว มีการกำหนดเงื่อนไขในการขอทำสำเนาเอกสารจดหมายเหตุ มีการกำหนดเงื่อนไขการขอทำสำเนาเอกสารจดหมายเหตุ ดังต่อไปนี้",
                                ),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                    '   - การสั่งทำสำเนาเอกสารผ่านช่องทาง Online สามารถใช้กับเอกสารประเภท เอกสารโสตทัศนภาพ และ แผนที่ แผนผัง แบบแปลน เท่านั้น'),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                    '   - จำกัดการขอทำสำเนาเอกสาร จำนวน 30 ภาพ หรือ รายการ / 1 คำสั่งขอทำสำเนา หากต้องการทำสำเนาเพิ่มเติมต้องทำรายการคำร้องใหม่'),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                    '   - การชำระค่าบริการ จะต้องทำการชำระค่าบริการภายใน 7 วัน ทางสำนักหอจดหมายเหตุ ขอสงวนสิทธิ์ยกเลิกคำสั่งทำสำเนาหากชำระเงินช้ากว่ากำหนด และหากต้องการสั่งทำสำเนา ขอให้ผู้ค้นคว้าทำรายการสั่งทำสำเนามาอีกครั้ง'),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  '**ทางสำนักฯ ขอสงวนสิทธิ์ ไม่ทำสำเนาเอกสารหากไม่ได้รับการยืนยันการชำระเงิน**',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
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
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              visibilityPay = !visibilityPay;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: const Text(
                                  "เงื่อนไขการชำระเงิน",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    visibilityPay
                        ? Container(
                            padding: const EdgeInsets.only(
                                left: defaultPadding,
                                bottom: defaultPadding * 1,
                                right: defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                SizedBox(height: defaultPadding),
                                Text(
                                  "   สำนักหอจดหมายเหตุแห่งชาติ กำหนดให้มีการขอทำสำเนาเอกสารจากระบบสืบค้นเอกสารจดหมายเหตุ ผ่านรูปแบบออนไลน์ได้แล้ว มีการกำหนดเงื่อนไขในการขอทำสำเนาเอกสารจดหมายเหตุ มีการกำหนดเงื่อนไขการขอทำสำเนาเอกสารจดหมายเหตุ ดังต่อไปนี้",
                                ),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                    '   ผู้ที่ทำคำขอทำสำเนาเอกสารต้องนำใบแจ้งชำระค่าบริการจากระบบ ไปชำระค่าบริการภายใน ระยะเวลา 7 วันทำการ'),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                    '   สำนักหอจดหมายเหตุแห่งชาติกำหนด รายละเอียดช่องทางการชำระค่าบริการ หลังจากได้รับข้อมูลการชำระค่าบริการแล้ว ระบบจะส่ง e-mail เพื่อยืนยันการชำระเงินและจัดส่งวันนัดรับเอกสาร ทาง email ที่ได้ลงทะเบียนไว้ในระบบ'),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                    '   การชำระค่าบริการ จะต้องทำการชำระค่าบริการภายใน 7 วัน หากเกินกำหนดรายการขอทำสำเนาจะถูกยกเลิกจากระบบ (ทางสำนักหอจดหมายเหตุ ขอสงวนสิทธิ์ยกเลิกคำสั่งทำสำเนาหากชำระเงินช้ากว่ากำหนด และหากต้องการสั่งทำสำเนา ขอให้ผู้ค้นคว้าทำรายการสั่งทำสำเนามาอีกครั้ง)'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '**ทางสำนักฯ ขอสงวนสิทธิ์ ไม่ทำสำเนาเอกสารหากไม่ได้รับการยืนยันการชำระเงิน**',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
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
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              visibilityDoc = !visibilityDoc;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: const Text(
                                  "เงื่อนไขการรับเอกสารจดหมายเหตุ",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    visibilityDoc
                        ? Container(
                            padding: const EdgeInsets.only(
                                left: defaultPadding,
                                bottom: defaultPadding * 1,
                                right: defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                SizedBox(height: defaultPadding),
                                Text(
                                  "   สำนักหอจดหมายเหตุแห่งชาติ กำหนดให้มีการขอทำสำเนาเอกสารจากระบบสืบค้นเอกสารจดหมายเหตุ ผ่านรูปแบบออนไลน์ได้แล้ว มีการกำหนดเงื่อนไขในการขอทำสำเนาเอกสารจดหมายเหตุดังต่อไปนี้",
                                ),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                    '   - การขอทำสำเนาเอกสารจดหมายเหตุ ผ่านช่องทางออนไลน์ ผู้ขอทำสำเนาต้องขอรับสำเนาเอกสารด้วยตัวเอง ณ ห้องบริการเอกสารจดหมายเหตุหน่วยงานเจ้าของเอกสารเท่านั้น'),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                    '   - สำนักหอจดหมายเหตุแห่งชาติยังไม่มีนโยบายการจัดส่งสำเนาเอกสารให้ผู้ขอทำสำเนา (กรณีมีการเปลี่ยนแปลงนโยบาย ขอสงวนสิทธิ์ในการเปลี่ยนแปลงโดยไม่ต้องแจ้งให้ทราบ)'),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                    '   - การขอรับเอกสารจะต้องนำบัตรประจำตัวประชาชนและใบนัดรับเอกสาร จาก e-mail ยืนยันการชำระเงินและจัดส่งใบนัดรับเอกสารมาแสดงด้วยทุกครั้ง'),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                    '   - การมอบอำนาจการรับเอกสารแทน ต้องมีเอกสารสำเนาบัตรประจำตัวประชาชนของผู้มอบอำนาจและผู้รับมอบอำนาจในการขอรับสำเนาเอกสาร (ทางสำนักหอจดหมายเหตุ ขอสงวนสิทธิ์ในการเปลี่ยนแปลงโดยไม่ต้องแจ้งให้ทราบ)'),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  '** บริการขอรับเอกสารจดหมายเหตุที่ขอทำสำเนาจากระบบ เวลาทําการ วันจันทร์ - ศุกร์ เวลา 09.00 - 16.00 น. ยกเว้นวันหยุดราชการ และวันหยุดนักขัตฤกษ์ **',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: defaultPadding * 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
