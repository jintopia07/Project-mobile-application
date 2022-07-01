// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/src/Searching/Models/ArchiveInfo.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/NearestPaperListViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/PaperListViewPage.dart';
import 'package:nat/src/Searching/Services/NATSearcher.dart';
import 'package:nat/src/Searching/Services/NATSearcherProvider.dart';

class PaperDetailViewPage extends StatefulWidget {
  final Content content;

  const PaperDetailViewPage({Key key, this.content}) : super(key: key);

  @override
  PaperDetailViewPageState createState() => PaperDetailViewPageState();
}

class PaperDetailViewPageState extends State<PaperDetailViewPage> {
  Widget _body = Center(child: const CircularProgressIndicator());
  NATSearcher natSearcher;
  Content currentContent = Content();
  List<Content> nearestContents = List<Content>.empty();

  Future<void> initializeInfoPaper() async {
    natSearcher = NATSearcherProvider().natSearcher;
    currentContent = widget.content;

    nearestContents = await natSearcher.getNearestContents(currentContent);
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  @override
  void initState() {
    super.initState();
    showInfoPaper();
  }

  showInfoPaper() async {
    initializeInfoPaper().then((value) => {
          setState(() => {
                _body = Scaffold(
                  appBar: AppBar(
                    title: const Text('ระบบสืบค้นหาเอกสารจดหมายเหตุ'),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.logout, color: Colors.white),
                        onPressed: (() {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaperListViewPage(),
                              ),
                              (Route<dynamic> route) => false);
                        }),
                      ),
                    ],
                    backgroundColor: Colors.teal[600],
                  ),
                  body: SingleChildScrollView(
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            _getinfo(currentContent),
                            const SizedBox(
                              height: defaultPadding * 1.5,
                            ),
                            SizedBox(
                                height: 800,
                                child: NearestPaperListViewPage(
                                  nearestContents,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              })
        });
  }

  Widget _headerSection() => Container(
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: const Text(
                      "คำค้นที่กรอก",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.brown,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text("คำค้น :"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      "",
                      style: TextStyle(color: Colors.blue[900]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _bodySection() => Container(
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
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: const Text(
                  "จำนวนเอกสารที่พบ",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.brown),
                ),
              ),
              Container(
                child: Divider(
                  color: Colors.grey,
                  height: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: defaultPadding,
                      ),
                      child: const Text("จดหมายเหตุประเภทลายลักษณ์อักษร :"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: defaultPadding,
                      ),
                      child: InkWell(
                        child: Text(
                          "",
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: defaultPadding,
                      ),
                      child: const Text("โสตทัศนจดหมายเหตุ-ภาพ :"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: InkWell(
                        child: Text(
                          '256767',
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: defaultPadding,
                      ),
                      child: const Text("จดหมายเหตุประเภทแผนที่ แผนผัง :"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: InkWell(
                        child: Text(
                          '',
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: defaultPadding,
                      ),
                      child: const Text("โสตทัศนจดหมายเหตุ-แถบบันทึกภาพ :"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: InkWell(
                        child: Text(
                          '143591',
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: defaultPadding,
                      ),
                      child: const Text("โสตทัศนจดหมายเหตุ-แถบบันทึกเสียง :"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: InkWell(
                        child: Text(
                          '127451',
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _getinfo(Content content) => Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(4, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  //horizontal: defaultPadding,
                  vertical: defaultPadding / 1,
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "รหัสเอกสาร :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(content.fullContentCode.toString()),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "ชื่อชุดเอกสาร :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(content.archiveDocumentAccount.accountName),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding / 1,
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "ชื่อเรื่อง :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(content.subject),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding / 1,
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "ระยะเวลาเอกสาร :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Text(""),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding / 1,
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "จำนวน :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(content.quantity.toString()),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding / 1,
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "หมายเลขไมโครฟิล์ม :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                        content.archiveDocumentAccount.microflimNO.toString()),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding / 1,
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "หมายเหตุเรื่อง :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(content.remarkSubject.toString()),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding / 1,
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "สาระสังเขป :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(content.abstractMessage.toString()),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "แหล่งที่มาเอกสาร :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(content.archiveDocumentAccount.ownerDocumentName
                        .toString()),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding / 1,
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "หน่วยงาน :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(content.branchName),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _documentSectionCard() => Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding / 1,
            ),
            alignment: FractionalOffset.topCenter,
            child: ListTile(
              title: const Text(
                "รหัสเอกสาร :",
                style: TextStyle(fontSize: 14),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: const Text('(1) ตง 1.4/2 กล่อง 1'),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: defaultPadding / 1,
              horizontal: defaultPadding / 1,
            ),
            alignment: FractionalOffset.topCenter,
            child: ListTile(
              title: const Text(
                "ชื่อเรื่อง :",
                style: TextStyle(fontSize: 14),
              ),
              subtitle: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: defaultPadding),
                    child: const Text(
                        'บัญชีแสดงรายการยอดจำนวนคนเข้าและออก นอกราชอาณาจักรไทย ประจำปี 2505'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: const Text(
                      'แสดงรายละเอียด',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ],
      );
}
